unit ImpurezasFrmU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Mask, Buttons, ExtCtrls, DB, DBAccess, Ora,
  MemDS, OraCall, DateUtils;

type
  TImpurezasFrm = class(TForm)
    pnlPrincipal: TPanel;
    pnlTopo: TPanel;
    btnSair: TSpeedButton;
    pnlDadosInconsistencias: TPanel;
    pnlVerificacaoIntegracao: TPanel;
    btnFiltrarImpurezas: TSpeedButton;
    grpDataImpurezas: TGroupBox;
    lblInicio: TLabel;
    lblFinal: TLabel;
    edtDtInicial: TMaskEdit;
    edtDtFinal: TMaskEdit;
    grdDadosImpurezas: TDBGrid;
    cnxConexaoImpurezas: TOraSession;
    qryImpurezas: TOraQuery;
    dtsImpurezas: TOraDataSource;
    qryImpurezasFORNECEDOR: TStringField;
    qryImpurezasCD_PARC: TStringField;
    qryImpurezasPARC: TStringField;
    qryImpurezasCANA_TOT: TFloatField;
    qryImpurezasCANA_ANLS: TFloatField;
    qryImpurezasIMP_MIN: TStringField;
    qryImpurezasIMP_VEG: TStringField;
    qryImpurezasDATA: TDateTimeField;
    procedure btnSairClick(Sender: TObject);
    procedure btnFiltrarImpurezasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdDadosImpurezasDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ImpurezasFrm: TImpurezasFrm;

implementation

uses
  InicialFrmU;

{$R *.dfm}

procedure TImpurezasFrm.btnFiltrarImpurezasClick(Sender: TObject);
var DataInicial, DataFinal : TDate;
begin

  DataInicial := StrToDate(edtDtInicial.Text);
  DataFinal := StrToDate(edtDtFinal.Text);
  qryImpurezas.Close;
  qryImpurezas.ParamByName('DataInicial').AsDate := DataInicial;
  qryImpurezas.ParamByName('DataFinal').AsDate := DataFinal;
  qryImpurezas.Open;
end;

procedure TImpurezasFrm.btnSairClick(Sender: TObject);
begin
  Close;
end;
procedure TImpurezasFrm.FormShow(Sender: TObject);
var DataInicialMask, DataFinalMask : TDate;
begin
  edtDtInicial.EditMask := '!99/99/9999;1;_';
  DataInicialMask := StartOfTheMonth(Date);
  edtDtInicial.Text := FormatDateTime('dd/mm/yyyy', DataInicialMask);

  edtDtFinal.EditMask := '!99/99/9999;1;_';
  DataFinalMask := EndOfTheMonth(Date);
  edtDtFinal.Text := FormatDateTime('dd/mm/yyyy', DataFinalMask);
end;

procedure TImpurezasFrm.grdDadosImpurezasDrawColumnCell(Sender: TObject;
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
    grdDadosImpurezas.Canvas.Brush.Color := LightGreen
  else
    grdDadosImpurezas.Canvas.Brush.Color := LighterGreen;

  // Define o estilo da fonte e cor do texto, se necessário
  grdDadosImpurezas.Canvas.Font.Style := [fsBold]; // Adiciona negrito, se desejado
  grdDadosImpurezas.Canvas.Font.Color := clBlack; // Cor do texto

  // Desenha a célula com as configurações definidas
  grdDadosImpurezas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.
