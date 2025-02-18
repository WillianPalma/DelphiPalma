unit InicialFrmU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, Grids, DBGrids, DB, DBAccess, Ora,
  MemDS, OraCall;

type
  TInicialFrm = class(TForm)
    pnlPrincipal: TPanel;
    pnlTopo: TPanel;
    btnSair: TSpeedButton;
    grpCodigoFrota: TGroupBox;
    edtCodigoFrota: TEdit;
    grdDadosFrota: TDBGrid;
    btnFiltrar: TSpeedButton;
    btnLimpar: TSpeedButton;
    cnxConexao: TOraSession;
    qryFrota: TOraQuery;
    dtsFrota: TOraDataSource;
    qryFrotaCODIGO_FROTA: TIntegerField;
    qryFrotaMODELO: TStringField;
    qryFrotaULTIMO_ABASTECIMENTO: TDateTimeField;
    qryFrotaQUANTIDADE_ABASTECIDA: TFloatField;
    qryFrotaULTIMO_KILOMETRO: TStringField;
    qryFrotaCOMBUSTIVEL: TStringField;
    procedure btnSairClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InicialFrm: TInicialFrm;

implementation

{$R *.dfm}

procedure TInicialFrm.btnFiltrarClick(Sender: TObject);
begin
  if edtCodigoFrota.Text = '' then
  begin
    ShowMessage('Insira um c�digo de frota.');
  end
  else
    qryFrota.Close;
    qryFrota.ParamByName('FROTA').AsString := edtCodigoFrota.Text;
    qryFrota.Open;
end;

procedure TInicialFrm.btnLimparClick(Sender: TObject);
begin
  edtCodigoFrota.Clear;
  qryFrota.Close;
  grdDadosFrota.DataSource := nil;
  grdDadosFrota.DataSource := dtsFrota;
end;

procedure TInicialFrm.btnSairClick(Sender: TObject);
begin
  Close;
end;

end.
