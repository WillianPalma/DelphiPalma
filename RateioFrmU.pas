unit RateioFrmU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, Grids, DBGrids, StdCtrls, Mask, DB, DBAccess, Ora,
  MemDS, OraCall, DateUtils;

type
  TRateioFrm = class(TForm)
    pnlPrincipal: TPanel;
    pnlTopo: TPanel;
    btnSair: TSpeedButton;
    cnxConexaoRateio: TOraSession;
    qryRateio: TOraQuery;
    dtsRateio: TOraDataSource;
    btnFiltrarRateio: TSpeedButton;
    grpDataRateio: TGroupBox;
    lblInicio: TLabel;
    lblFinal: TLabel;
    edtDtInicial: TMaskEdit;
    edtDtFinal: TMaskEdit;
    grdDadosRateio: TDBGrid;
    qryRateioEQUIPAMENTO: TIntegerField;
    qryRateioTONELADAS: TFloatField;
    qryRateioVIAGENS: TFloatField;
    qryRateioCARGAS: TFloatField;
    qryRateioRAIO: TFloatField;
    qryRateioRATEIO: TFloatField;
    pnlDadosDatas: TPanel;
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFiltrarRateioClick(Sender: TObject);
    procedure grdDadosRateioDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RateioFrm: TRateioFrm;

implementation

uses
  InicialFrmU;

{$R *.dfm}

procedure TRateioFrm.btnFiltrarRateioClick(Sender: TObject);
var DataInicial, DataFinal : TDate;
begin

  DataInicial := StrToDate(edtDtInicial.Text);
  DataFinal := StrToDate(edtDtFinal.Text);
  qryRateio.Close;
  qryRateio.ParamByName('DataInicial').AsDate := DataInicial;
  qryRateio.ParamByName('DataFinal').AsDate := DataFinal;
  qryRateio.Open;
end;

procedure TRateioFrm.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TRateioFrm.FormShow(Sender: TObject);
var DataInicialMask, DataFinalMask : TDate;
begin
  edtDtInicial.EditMask := '!99/99/9999;1;_';
  DataInicialMask := StartOfTheMonth(Date);
  edtDtInicial.Text := FormatDateTime('dd/mm/yyyy', DataInicialMask);

  edtDtFinal.EditMask := '!99/99/9999;1;_';
  DataFinalMask := EndOfTheMonth(Date);
  edtDtFinal.Text := FormatDateTime('dd/mm/yyyy', DataFinalMask);
end;

procedure TRateioFrm.grdDadosRateioDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
const
  LightGreen = $90EE90;  // Verde claro
  LighterGreen = $D0F0C0; // Verde mais claro
var
  RowIndex: Integer;
begin
  // Obtém o índice da linha atual
  RowIndex := (Sender as TDBGrid).DataSource.DataSet.RecNo - 1;

  // Alterna as cores das linhas
  if Odd(RowIndex) then
    grdDadosRateio.Canvas.Brush.Color := LightGreen
  else
    grdDadosRateio.Canvas.Brush.Color := LighterGreen;

  // Define o estilo da fonte e cor do texto, se necessário
  grdDadosRateio.Canvas.Font.Style := [fsBold]; // Adiciona negrito, se desejado
  grdDadosRateio.Canvas.Font.Color := clBlack; // Cor do texto

  // Desenha a célula com as configurações definidas
  grdDadosRateio.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.
