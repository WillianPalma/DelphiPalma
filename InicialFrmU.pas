unit InicialFrmU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, pngimage;

type
  TPrincipalFrm = class(TForm)
    pnlPrincipal: TPanel;
    pnlTopo: TPanel;
    btnSair: TSpeedButton;
    pnlBotoesLado: TPanel;
    btnIntegracao: TSpeedButton;
    btnInconsistencias: TSpeedButton;
    btnRateio: TSpeedButton;
    pnlLogo: TPanel;
    imgLogo: TImage;
    btnFechamentoPims: TSpeedButton;
    btnImpurezas: TSpeedButton;
    procedure btnSairClick(Sender: TObject);
    procedure btnIntegracaoClick(Sender: TObject);
    procedure btnInconsistenciasClick(Sender: TObject);
    procedure btnRateioClick(Sender: TObject);
    procedure btnImpurezasClick(Sender: TObject);
    procedure btnFechamentoPimsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrincipalFrm: TPrincipalFrm;

implementation

uses
  IntegracaoFrmU, InconsistenciasFrmU, RateioFrmU, FechamentoPimsFrmU, ImpurezasFrmU;

{$R *.dfm}

procedure TPrincipalFrm.btnFechamentoPimsClick(Sender: TObject);
begin
  Application.CreateForm(TFechamentoPimsFrm, FechamentoPimsFrm);
  FechamentoPimsFrm.ShowModal;
  FreeAndNil(FechamentoPimsFrm);
end;

procedure TPrincipalFrm.btnImpurezasClick(Sender: TObject);
begin
  Application.CreateForm(TImpurezasFrm, ImpurezasFrm);
  ImpurezasFrm.ShowModal;
  FreeAndNil(ImpurezasFrm);
end;

procedure TPrincipalFrm.btnInconsistenciasClick(Sender: TObject);
begin
  Application.CreateForm(TInconsistenciasFrm, InconsistenciasFrm);
  InconsistenciasFrm.ShowModal;
  FreeAndNil(InconsistenciasFrm);
end;

procedure TPrincipalFrm.btnIntegracaoClick(Sender: TObject);
begin
  Application.CreateForm(TIntegracaoFrm, IntegracaoFrm);
  IntegracaoFrm.ShowModal;
  FreeAndNil(IntegracaoFrm);
end;

procedure TPrincipalFrm.btnRateioClick(Sender: TObject);
begin
  Application.CreateForm(TRateioFrm, RateioFrm);
  RateioFrm.ShowModal;
  FreeAndNil(RateioFrm);
end;

procedure TPrincipalFrm.btnSairClick(Sender: TObject);
begin
  Close;
end;

end.
