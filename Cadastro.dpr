program Cadastro;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uSobre in 'uSobre.pas' {frmSobre},
  uSubCadastros in 'uSubCadastros.pas' {frmSubCadastros},
  uDM in 'uDM.pas' {DM: TDataModule},
  uProdutos in 'uProdutos.pas' {frmProdutos},
  uCalendario in 'uCalendario.pas' {frmCalendario};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
