unit uSubCadastros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, uDM;

type
  TfrmSubCadastros = class(TForm)
    GroupBox8: TGroupBox;
    btNovo: TButton;
    btSalvar: TButton;
    brImprimir: TButton;
    btExcluir: TButton;
    btLimpar: TButton;
    GroupBox9: TGroupBox;
    btSair: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    gbNome: TGroupBox;
    Label2: TLabel;
    edtDescricao: TEdit;
    gbCodigo: TGroupBox;
    Label1: TLabel;
    edtCodigo: TEdit;
    gridCategoria: TDBGrid;
    dsCategoria: TDataSource;
    procedure btSairClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure HabilitaCampos;
    procedure DesabilitaCampos;
    procedure btLimparClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure gridCategoriaDblClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSubCadastros: TfrmSubCadastros;
  Operacao        : string;

implementation

{$R *.dfm}
procedure TfrmSubCadastros.HabilitaCampos;
begin
  Operacao           := 'Inclusão';
  edtCodigo.Clear;
  edtDescricao.Clear;

  gbCodigo.Enabled     := False;
  gbNome.Enabled       := True;

  btNovo.Enabled     := False;
  btSalvar.Enabled   := True;
  btLimpar.Enabled   := True;
  btExcluir.Enabled  := True;
end;

procedure TfrmSubCadastros.DesabilitaCampos;
begin
  edtCodigo.Clear;
  edtDescricao.Clear;

  gbCodigo.Enabled     := True;
  gbNome.Enabled       := False;

  btNovo.Enabled     := True;
  btSalvar.Enabled   := False;
  btLimpar.Enabled   := False;
  btExcluir.Enabled  := False;
end;

procedure TfrmSubCadastros.edtCodigoExit(Sender: TObject);
begin
 if edtCodigo.Text <> '' then
  begin
    With DM.FDQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT * FROM Categoria WHERE Codigo = ' + edtCodigo.Text;
      Open;
      if RecordCount = 0 then
      begin
        Application.MessageBox(PChar('Nenhum registro encontrado para o código: ' + edtCodigo.Text),'Aviso',MB_ICONERROR);
        edtCodigo.Clear;
        edtCodigo.SetFocus;
      end
      else
      begin
        HabilitaCampos();

        edtCodigo.Text    := FieldByName('Codigo').Value;
        edtDescricao.Text := FieldByName('Descricao').Value;

        Operacao       := 'Alteração';
      end; // Fim do if RecordCount = 0
    end;
  end; // Fim do if edtCodigo.Text  = ''
end;

procedure TfrmSubCadastros.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  // Enter vira Tab
  if Key = #13 then
  begin
    Key := #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;

  // Permite somente números no Edit
  if not( Key in['0'..'9',#08] ) then key:=#0;
end;

procedure TfrmSubCadastros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmSubCadastros := Nil;
  Action          := caFree;
end;

procedure TfrmSubCadastros.gridCategoriaDblClick(Sender: TObject);
begin
  if btLimpar.Enabled then
  begin
    Application.MessageBox(PChar('Já existe um registro na tela para alteração ou cadastro.' + #13 + #13 + 'Salve ou cancele a alteração antes de alterar outro registro.'),'Aviso',MB_ICONINFORMATION);

    Exit;
  end;

  edtCodigo.Text := DM.FDQuery_Categoria.FieldByName('Codigo').Value;

  edtCodigo.SetFocus;

  // Executa um Tab
  Perform(Wm_NextDlgCtl,0,0);
end;

procedure TfrmSubCadastros.btExcluirClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Deseja realmente excluir o registro: ' + edtCodigo.Text + '?'),'Aviso',MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    With DM.FDQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'DELETE FROM Categoria WHERE Codigo = ' + edtCodigo.Text;
      ExecSQL;
      Application.MessageBox(PChar('Registro excluído com sucesso'),'Aviso',MB_ICONINFORMATION);
      DesabilitaCampos();

      // Atualiza os dados da grid de consulta
      if (DM.FDQuery_Categoria.Active = True) then DM.FDQuery_Categoria.Active := False;
      DM.FDQuery_Categoria.Active := True;
    end;
  end;
end;

procedure TfrmSubCadastros.btLimparClick(Sender: TObject);
begin
  DesabilitaCampos();

  edtCodigo.SetFocus;
end;

procedure TfrmSubCadastros.btNovoClick(Sender: TObject);
begin
  HabilitaCampos();

  With DM.FDQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT (MAX(Codigo)+1) AS Proximo FROM Categoria';
    Open;
    if FieldByName('Proximo').Value <> Null then
    begin
      edtCodigo.Text := FieldByName('Proximo').Value;
    end
    else
    begin
      edtCodigo.Text := '1';
    end;
  end;

  edtDescricao.SetFocus;
end;

procedure TfrmSubCadastros.btSairClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmSubCadastros.btSalvarClick(Sender: TObject);
begin
  if edtDescricao.Text = '' then
  begin
    Application.MessageBox(PChar('O campo "Descrição" deve ser preenchido'),'Aviso',MB_ICONERROR);
    edtDescricao.SetFocus;
    Exit;
  end;

With DM.FDQuery do
  begin
    Close;
    SQL.Clear;
    if Operacao = 'Inclusão' then
    begin
      SQL.Add(' INSERT INTO Categoria (Descricao) VALUES (''' + edtDescricao.Text + ''' )');
    end
    else if Operacao = 'Alteração' then
    begin
      SQL.Add(' UPDATE Categoria SET Descricao = ''' + edtDescricao.Text + ''' WHERE Codigo = ' + edtCodigo.Text + ' ');
    end;
    ExecSQL;
    Application.MessageBox(PChar('Registro salvo com sucesso'),'Aviso',MB_ICONINFORMATION);
    DesabilitaCampos();

    // Atualiza os dados da grid de consulta
    if (DM.FDQuery_Categoria.Active = True) then DM.FDQuery_Categoria.Active := False;
    DM.FDQuery_Categoria.Active := True;

    edtCodigo.SetFocus;
  end;

end;

end.
