unit uProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, uDM, Vcl.Mask;

type
  TfrmProdutos = class(TForm)
    GroupBox8: TGroupBox;
    btNovo: TButton;
    btSalvar: TButton;
    brImprimir: TButton;
    btExcluir: TButton;
    btLimpar: TButton;
    GroupBox9: TGroupBox;
    btSair: TButton;
    pcProdutos: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    gbCodigo: TGroupBox;
    Label1: TLabel;
    edtCodigo: TEdit;
    gbNome: TGroupBox;
    Label2: TLabel;
    edtDescricao: TEdit;
    gridProdutos: TDBGrid;
    gbDetalhes: TGroupBox;
    edtPrecoCusto: TEdit;
    Label3: TLabel;
    edtPrecoVenda: TEdit;
    Label4: TLabel;
    cbCategoria: TDBLookupComboBox;
    Label5: TLabel;
    dsCategoria: TDataSource;
    dsProdutos: TDataSource;
    procedure edtPrecoCustoExit(Sender: TObject);
    procedure edtPrecoVendaExit(Sender: TObject);
    procedure edtPrecoCustoKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrecoVendaKeyPress(Sender: TObject; var Key: Char);
    procedure HabilitaCampos;
    procedure DesabilitaCampos;
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure btSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btExcluirClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure gridProdutosDblClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProdutos: TfrmProdutos;
  Operacao        : string;

implementation

{$R *.dfm}

procedure TfrmProdutos.HabilitaCampos;
begin
  Operacao           := 'Inclusão';
  edtCodigo.Clear;
  edtDescricao.Clear;
  edtPrecoCusto.Clear;
  edtPrecoVenda.Clear;
  cbCategoria.KeyValue := 0;

  gbCodigo.Enabled     := False;
  gbNome.Enabled       := True;
  gbDetalhes.Enabled   := True;

  btNovo.Enabled     := False;
  btSalvar.Enabled   := True;
  btLimpar.Enabled   := True;
  btExcluir.Enabled  := True;
end;

procedure TfrmProdutos.btExcluirClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Deseja realmente excluir o registro: ' + edtCodigo.Text + '?'),'Aviso',MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    With DM.FDQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'DELETE FROM Produtos WHERE Codigo = ' + edtCodigo.Text;
      ExecSQL;
      Application.MessageBox(PChar('Registro excluído com sucesso'),'Aviso',MB_ICONINFORMATION);
      DesabilitaCampos();

      // Atualiza os dados da grid de consulta
      if (DM.FDQuery_Produtos.Active = True) then DM.FDQuery_Produtos.Active := False;
      DM.FDQuery_Produtos.Active := True;
    end;
  end;
end;

procedure TfrmProdutos.btLimparClick(Sender: TObject);
begin
  DesabilitaCampos();

  // Marca a primeira aba como ativa
  pcProdutos.ActivePageIndex := 0;

  edtCodigo.SetFocus;
end;

procedure TfrmProdutos.btNovoClick(Sender: TObject);
begin
  // Marca a primeira aba como ativa
  pcProdutos.ActivePageIndex := 0;

  HabilitaCampos();

  With DM.FDQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT (MAX(Codigo)+1) AS Proximo FROM Produtos';
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

procedure TfrmProdutos.btSairClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmProdutos.btSalvarClick(Sender: TObject);
begin
  if edtDescricao.Text = '' then
  begin
    Application.MessageBox(PChar('O campo "Descrição" deve ser preenchido'),'Aviso',MB_ICONERROR);
    edtDescricao.SetFocus;
    Exit;
  end;

  if edtPrecoCusto.Text = '' then
  begin
    Application.MessageBox(PChar('O campo "Preço de Custo" deve ser preenchido'),'Aviso',MB_ICONERROR);
    edtPrecoCusto.SetFocus;
    Exit;
  end;

  if edtPrecoVenda.Text = '' then
  begin
    Application.MessageBox(PChar('O campo "Preço de Venda" deve ser preenchido'),'Aviso',MB_ICONERROR);
    edtPrecoVenda.SetFocus;
    Exit;
  end;

  if cbCategoria.KeyValue = 0  then
  begin
    Application.MessageBox(PChar('O campo "Categoria" deve ser preenchido'),'Aviso',MB_ICONERROR);
    cbCategoria.SetFocus;
    Exit;
  end;

  With DM.FDQuery do
  begin
    Close;
    SQL.Clear;
    if Operacao = 'Inclusão' then
    begin
      SQL.Add(' INSERT INTO Produtos (Descricao, PrecoCusto, PrecoVenda, CodigoCategoria) VALUES (''' + edtDescricao.Text + ''', ');
      SQL.Add(' ''' + edtPrecoCusto.Text + ''', ''' + edtPrecoVenda.Text + ''', ''' + VarToStr(cbCategoria.KeyValue) + ''' )'     );
    end
    else if Operacao = 'Alteração' then
    begin
      SQL.Add(' UPDATE Produtos SET Descricao = ''' + edtDescricao.Text + ''', PrecoCusto = ''' + edtPrecoCusto.Text + ''', ');
      SQL.Add(' PrecoVenda = ''' + edtPrecoVenda.Text + ''', CodigoCategoria = ''' + VarToStr(cbCategoria.KeyValue) + ''' WHERE Codigo = ' + edtCodigo.Text + ' ');
    end;
    ExecSQL;
    Application.MessageBox(PChar('Registro salvo com sucesso'),'Aviso',MB_ICONINFORMATION);
    DesabilitaCampos();

    // Marca a primeira aba como ativa
    pcProdutos.ActivePageIndex := 0;

    // Atualiza os dados da grid de consulta
    if (DM.FDQuery_Produtos.Active = True) then DM.FDQuery_Produtos.Active := False;
    DM.FDQuery_Produtos.Active := True;

    edtCodigo.SetFocus;
  end;
end;

procedure TfrmProdutos.DesabilitaCampos;
begin
  edtCodigo.Clear;
  edtDescricao.Clear;
  edtPrecoCusto.Clear;
  edtPrecoVenda.Clear;
  cbCategoria.KeyValue := 0;

  gbCodigo.Enabled     := True;
  gbNome.Enabled       := False;
  gbDetalhes.Enabled   := False;

  btNovo.Enabled     := True;
  btSalvar.Enabled   := False;
  btLimpar.Enabled   := False;
  btExcluir.Enabled  := False;
end;

procedure TfrmProdutos.edtCodigoExit(Sender: TObject);
begin
  if edtCodigo.Text <> '' then
  begin
    With DM.FDQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT * FROM Produtos WHERE Codigo = ' + edtCodigo.Text;
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

        edtCodigo.Text       := FieldByName('Codigo').Value;
        edtDescricao.Text    := FieldByName('Descricao').Value;

        edtPrecoCusto.Text   := FieldByName('PrecoCusto').Value;
        edtPrecoCusto.Text   := FormatFloat('#####0.00',StrToFloat(edtPrecoCusto.Text));

        edtPrecoVenda.Text   := FieldByName('PrecoVenda').Value;
        edtPrecoVenda.Text   := FormatFloat('#####0.00',StrToFloat(edtPrecoVenda.Text));

        cbCategoria.KeyValue := FieldByName('CodigoCategoria').Value;

        Operacao             := 'Alteração';
      end; // Fim do if RecordCount = 0
    end;
  end; // Fim do if edtCodigo.Text  = ''
end;

procedure TfrmProdutos.edtCodigoKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmProdutos.edtPrecoCustoExit(Sender: TObject);
begin
  if trim(edtPrecoCusto.Text) = '' then exit;

  edtPrecoCusto.Text := FormatFloat('#####0.00',StrToFloat(edtPrecoCusto.Text));
end;

procedure TfrmProdutos.edtPrecoCustoKeyPress(Sender: TObject; var Key: Char);
begin
  If ((not(Key in ['0'..'9',#8])) and (not(key in [',',#8])))then
  Key := #0;
  If (key in [','])and (Pos(',',edtPrecoCusto.text)<>0) then
  Key :=#0;
end;

procedure TfrmProdutos.edtPrecoVendaExit(Sender: TObject);
begin
  if trim(edtPrecoVenda.Text) = '' then exit;

  edtPrecoVenda.Text := FormatFloat('#####0.00',StrToFloat(edtPrecoVenda.Text));
end;

procedure TfrmProdutos.edtPrecoVendaKeyPress(Sender: TObject; var Key: Char);
begin
  If ((not(Key in ['0'..'9',#8])) and (not(key in [',',#8])))then
  Key := #0;
  If (key in [','])and (Pos(',',edtPrecoVenda.text)<>0) then
  Key :=#0;
end;

procedure TfrmProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmProdutos := Nil;
  Action      := caFree;
end;

procedure TfrmProdutos.FormCreate(Sender: TObject);
begin
  // Marca a primeira aba como ativa
  pcProdutos.ActivePageIndex := 0;
end;

procedure TfrmProdutos.gridProdutosDblClick(Sender: TObject);
begin
  if btLimpar.Enabled then
  begin
    Application.MessageBox(PChar('Já existe um registro na tela para alteração ou cadastro.' + #13 + #13 + 'Salve ou cancele a alteração antes de alterar outro registro.'),'Aviso',MB_ICONINFORMATION);
    // Marca a primeira aba como ativa
    pcProdutos.ActivePageIndex := 0;
    Exit;
  end;

  edtCodigo.Text := DM.FDQuery_Produtos.FieldByName('Codigo').Value;

  // Marca a primeira aba como ativa
  pcProdutos.ActivePageIndex := 0;

  // Executa um Tab
  Perform(Wm_NextDlgCtl,0,0);
end;

end.
