unit InconsistenciasFrmU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, Grids, DBGrids, StdCtrls, Mask, DB, DBAccess, Ora,
  MemDS, OraCall, DateUtils;

type
  TInconsistenciasFrm = class(TForm)
    pnlPrincipal: TPanel;
    pnlTopo: TPanel;
    btnSair: TSpeedButton;
    pnlDadosInconsistencias: TPanel;
    pnlVerificacaoIntegracao: TPanel;
    btnFiltrarInconsis: TSpeedButton;
    cnxConexIncons: TOraSession;
    qryInconsis: TOraQuery;
    dtsInconsis: TOraDataSource;
    qryInconsisDATA: TDateTimeField;
    qryInconsisEQUIPAMENTO: TIntegerField;
    qryInconsisMODELO: TStringField;
    qryInconsisHORAS: TFloatField;
    grdDadosInconsis: TDBGrid;
    grpDataInconsis: TGroupBox;
    lblInicio: TLabel;
    lblFinal: TLabel;
    edtDtInicial: TMaskEdit;
    edtDtFinal: TMaskEdit;

    procedure btnFiltrarInconsisClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure grdDadosInconsisDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InconsistenciasFrm: TInconsistenciasFrm;

implementation

uses
  InicialFrmU;

{$R *.dfm}

procedure TInconsistenciasFrm.btnFiltrarInconsisClick(Sender: TObject);
var DataInicial, DataFinal : TDate;
begin

  DataInicial := StrToDate(edtDtInicial.Text);
  DataFinal := StrToDate(edtDtFinal.Text);
  qryInconsis.Close;
  qryInconsis.ParamByName('DataInicial').AsDate := DataInicial;
  qryInconsis.ParamByName('DataFinal').AsDate := DataFinal;
  qryInconsis.Open;
end;



procedure TInconsistenciasFrm.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TInconsistenciasFrm.FormShow(Sender: TObject);
var DataInicialMask, DataFinalMask : TDate;
begin
  edtDtInicial.EditMask := '!99/99/9999;1;_';
  DataInicialMask := StartOfTheMonth(Date);
  edtDtInicial.Text := FormatDateTime('dd/mm/yyyy', DataInicialMask);

  edtDtFinal.EditMask := '!99/99/9999;1;_';
  DataFinalMask := EndOfTheMonth(Date);
  edtDtFinal.Text := FormatDateTime('dd/mm/yyyy', DataFinalMask);
end;

procedure TInconsistenciasFrm.grdDadosInconsisDrawColumnCell(Sender: TObject;
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
    grdDadosInconsis.Canvas.Brush.Color := LightGreen
  else
    grdDadosInconsis.Canvas.Brush.Color := LighterGreen;

  // Define o estilo da fonte e cor do texto, se necessário
  grdDadosInconsis.Canvas.Font.Style := [fsBold]; // Adiciona negrito, se desejado
  grdDadosInconsis.Canvas.Font.Color := clBlack; // Cor do texto

  // Desenha a célula com as configurações definidas
  grdDadosInconsis.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;
end.
