unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uSobre, Vcl.ComCtrls,
  Vcl.ToolWin, System.ImageList, Vcl.ImgList, uSubCadastros, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, uProdutos;

type
  TfrmPrincipal = class(TForm)
    menuPrincipal: TMainMenu;
    Cadastros1: TMenuItem;
    Produtos1: TMenuItem;
    SubCadastros1: TMenuItem;
    Categoria1: TMenuItem;
    Sobre1: TMenuItem;
    ExemploDelphiTokyoSQLite1: TMenuItem;
    botoesImageList: TImageList;
    barraImageList: TImageList;
    menuImageList: TImageList;
    N1: TMenuItem;
    N2: TMenuItem;
    Sair1: TMenuItem;
    imgFundo: TImage;
    barraFerramentas: TToolBar;
    btCompras: TToolButton;
    ToolButton3: TToolButton;
    btCalendario: TToolButton;
    ToolButton4: TToolButton;
    btSair: TToolButton;
    procedure ExemploDelphiTokyoSQLite1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure Categoria1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure btComprasClick(Sender: TObject);
    procedure btCalendarioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uCalendario;

procedure TfrmPrincipal.btCalendarioClick(Sender: TObject);
begin
  // Chama um form MDIChild na tela
  if frmCalendario = nil then
  begin
    Application.createForm(TfrmCalendario, frmCalendario);
  end
  else
  begin
    with frmCalendario do
    begin
      Show;
      BringToFront;
    end;
  end;
end;

procedure TfrmPrincipal.btComprasClick(Sender: TObject);
begin
  // Chama um form MDIChild na tela
  if frmProdutos = nil then
  begin
    Application.createForm(TfrmProdutos, frmProdutos);
  end
  else
    with frmProdutos do
    begin
      Show;
      BringToFront;
    end;
end;

procedure TfrmPrincipal.btSairClick(Sender: TObject);
begin
  If Application.MessageBox('Deseja realmente encerrar a aplicação?','Aviso',MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    Application.Terminate;
  end;
end;

procedure TfrmPrincipal.Categoria1Click(Sender: TObject);
begin
  // Chama um form MDIChild na tela
  if frmSubCadastros = nil then
  begin
    Application.createForm(TfrmSubCadastros, frmSubCadastros);
  end
  else
    with frmSubCadastros do
    begin
      Show;
      BringToFront;
    end;
end;

procedure TfrmPrincipal.ExemploDelphiTokyoSQLite1Click(Sender: TObject);
begin
  // Chama um form MDIChild na tela
  if frmSobre = nil then
  begin
    Application.createForm(TfrmSobre, frmSobre);
  end
  else
    with frmSobre do
    begin
      Show;
      BringToFront;
    end;
end;

procedure TfrmPrincipal.FormResize(Sender: TObject);
begin
  // Centraliza e redimensiona a figura de fundo do frmPrincipal
  imgFundo.Height := clientHeight;
  imgFundo.Width  := clientWidth;
  imgFundo.Top    := (clientHeight - imgFundo.Height) div 2;
  imgFundo.Left   := (clientWidth  - imgFundo.Width)  div 2;
end;

procedure TfrmPrincipal.Produtos1Click(Sender: TObject);
begin
  // Chama um form MDIChild na tela
  if frmProdutos = nil then
  begin
    Application.createForm(TfrmProdutos, frmProdutos);
  end
  else
    with frmProdutos do
    begin
      Show;
      BringToFront;
    end;
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  If Application.MessageBox('Deseja realmente encerrar a aplicação?','Aviso',MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    Application.Terminate;
  end;
end;

end.
