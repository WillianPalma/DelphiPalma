unit FechamentoPimsFrmU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, Grids, DBGrids, DB, DBAccess, Ora, MemDS, OraCall;

type
  TFechamentoPimsFrm = class(TForm)
    pnlPrincipal: TPanel;
    pnlTopo: TPanel;
    btnSair: TSpeedButton;
    btnFiltrarRateio: TSpeedButton;
    grdFechaPims: TDBGrid;
    cnxConexaoFechaPims: TOraSession;
    qryFechaPims: TOraQuery;
    dtsFechaPims: TOraDataSource;
    qryFechaPimsPROCESSO: TStringField;
    qryFechaPimsDATA: TDateTimeField;
    qryFechaPimsSECAO: TStringField;
    qryFechaPimsENTRADA: TStringField;
    qryFechaPimsSTATUS: TStringField;
    procedure btnSairClick(Sender: TObject);
    procedure btnFiltrarRateioClick(Sender: TObject);
    procedure grdFechaPimsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FechamentoPimsFrm: TFechamentoPimsFrm;

implementation

uses
  InicialFrmU;

{$R *.dfm}

procedure TFechamentoPimsFrm.btnFiltrarRateioClick(Sender: TObject);
begin
  qryFechaPims.Close;
  qryFechaPims.Open;
  qryFechaPims.Refresh;
end;

procedure TFechamentoPimsFrm.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFechamentoPimsFrm.grdFechaPimsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
const
  LightGreen = $90EE90;  // Verde claro
  LighterGreen = $D0F0C0; // Verde mais claro
var
  RowIndex: Integer;
begin
  RowIndex := (Sender as TDBGrid).DataSource.DataSet.RecNo - 1;

  // Define as cores padrão para linhas alternadas
  if Odd(RowIndex) then
    grdFechaPims.Canvas.Brush.Color := LightGreen
  else
    grdFechaPims.Canvas.Brush.Color := LighterGreen;

  // Verifica se o status está em atraso e aplica a formatação vermelha
  if qryFechaPims.FieldByName('STATUS').AsString = 'ATENÇÃO! PROCESSO EM ATRASO' then
  begin
    grdFechaPims.Canvas.Brush.Color := clRed; // Fundo vermelho para atraso
    grdFechaPims.Canvas.Font.Color := clWhite; // Texto branco para contraste
    grdFechaPims.Canvas.Font.Style := [fsBold];
  end
  else
  begin
    // Formatação padrão para as linhas
    grdFechaPims.Canvas.Font.Style := [fsBold];
    grdFechaPims.Canvas.Font.Color := clBlack;
  end;

  // Desenha a célula com as configurações definidas
  grdFechaPims.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;


end.
