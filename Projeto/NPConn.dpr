program NPConn;

uses
  Forms,
  InicialFrmU in '..\Forms\InicialFrmU.pas' {PrincipalFrm},
  IntegracaoFrmU in '..\Forms\IntegracaoFrmU.pas' {IntegracaoFrm},
  InconsistenciasFrmU in '..\Forms\InconsistenciasFrmU.pas' {InconsistenciasFrm},
  RateioFrmU in '..\Forms\RateioFrmU.pas' {RateioFrm},
  FechamentoPimsFrmU in '..\Forms\FechamentoPimsFrmU.pas' {FechamentoPimsFrm},
  ImpurezasFrmU in '..\Forms\ImpurezasFrmU.pas' {ImpurezasFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPrincipalFrm, PrincipalFrm);
  Application.CreateForm(TRateioFrm, RateioFrm);
  Application.CreateForm(TFechamentoPimsFrm, FechamentoPimsFrm);
  Application.CreateForm(TImpurezasFrm, ImpurezasFrm);
  Application.Run;
end.
