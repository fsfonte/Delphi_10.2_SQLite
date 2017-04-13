unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Windows,Forms;

type
  TDM = class(TDataModule)
    FDConnection: TFDConnection;
    FDQuery: TFDQuery;
    FDQuery_Categoria: TFDQuery;
    FDQuery_Produtos: TFDQuery;
    FDQuery_ProdutosCodigo: TFDAutoIncField;
    FDQuery_ProdutosDescricao: TWideStringField;
    FDQuery_ProdutosPrecoCusto: TFloatField;
    FDQuery_ProdutosPrecoVenda: TFloatField;
    FDQuery_ProdutosCodigoCategoria: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  // Inicializa a conexão com o SQLite
  try
    if (FDConnection.Connected = True) then FDConnection.Connected := False;
    FDConnection.Params.Database := ExtractFilePath(Application.ExeName) + '\ProdutosDelphi.db';
    FDConnection.Connected := True;
  except
    on E : Exception do
    Application.MessageBox(PChar('Erro ao conectar ao banco de dados: ' + E.Message),'Aviso',MB_ICONERROR);
  end;

   // Alimenta a consulta de Categorias
  if (FDQuery_Categoria.Active = True) then FDQuery_Categoria.Active := False;
  FDQuery_Categoria.Active := True;

  // Alimenta a consulta de Produtos
  if (FDQuery_Produtos.Active = True) then FDQuery_Produtos.Active := False;
  FDQuery_Produtos.Active := True;
end;

end.
