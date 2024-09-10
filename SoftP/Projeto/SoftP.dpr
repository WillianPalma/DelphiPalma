program SoftP;

uses
  Forms,
  InicialFrmU in '..\Forms\InicialFrmU.pas' {InicialFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TInicialFrm, InicialFrm);
  Application.Run;
end.
