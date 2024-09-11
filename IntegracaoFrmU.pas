unit IntegracaoFrmU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, CategoryButtons, ComCtrls, StdCtrls, Grids,
  DBGrids, DB, DBAccess, Ora, MemDS, OraCall, Mask, DateUtils, DBCtrls;

type
  TIntegracaoFrm = class(TForm)
    pnlPrincipal: TPanel;
    pnlTopo: TPanel;
    btnSair: TSpeedButton;
    pnlDadosIntegracao: TPanel;
    pgcDadosIntegracao: TPageControl;
    abaStatusIntegracao: TTabSheet;
    abaVerificaIntegracao: TTabSheet;
    pnlStatusIntegracao: TPanel;
    btnAtualizaStatus: TSpeedButton;
    lblPendencias: TLabel;
    grdPendenciasIntegracao: TDBGrid;
    pnlVerificacaoIntegracao: TPanel;
    grpDataIntegracao: TGroupBox;
    lblDataInicial: TLabel;
    lblDataFinal: TLabel;
    btnFiltrarIntegracao: TSpeedButton;
    grdDadosIntegracaoComb: TDBGrid;
    cnxConexao: TOraSession;
    qryStatusIntegracao: TOraQuery;
    qryStatusIntegracaoBOLETIM: TFloatField;
    qryStatusIntegracaoORIGEM_INTEGRACAO: TStringField;
    qryStatusIntegracaoEQUIPAMENTO: TIntegerField;
    qryStatusIntegracaoMOVIMENTO: TDateTimeField;
    qryStatusIntegracaoOS_INDUSTRIA: TFloatField;
    qryStatusIntegracaoTP_MOVIMENTO: TStringField;
    qryStatusIntegracaoCODIGO_MATERIAL: TStringField;
    qryStatusIntegracaoMATERIAL: TStringField;
    qryStatusIntegracaoQUANTIDADE: TFloatField;
    qryStatusIntegracaoUNIDADE: TStringField;
    qryStatusIntegracaoMENSAGEM_DE_ERRO: TStringField;
    dtsStatusIntegracao: TOraDataSource;
    lblSemPendencias: TLabel;
    qryValidaCombustiveis: TOraQuery;
    dtsValidaCombustiveis: TOraDataSource;
    edtDataInicial: TMaskEdit;
    edtDataFinal: TMaskEdit;
    rdgSelectComb: TRadioGroup;
    qryValidaCombustiveisMOVIMENTO: TDateTimeField;
    qryValidaCombustiveisCOMBUSTIVEL: TStringField;
    qryValidaCombustiveisQUANTIDADE_ADM: TFloatField;
    qryValidaCombustiveisQUANTIDADE_PIMS: TFloatField;
    qryValidaCombustiveisDIFERENCA: TFloatField;
    procedure btnSairClick(Sender: TObject);
    procedure btnAtualizaStatusClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure pgcDadosIntegracaoChange(Sender: TObject);
    procedure btnFiltrarIntegracaoClick(Sender: TObject);
    procedure abaStatusIntegracaoShow(Sender: TObject);
    procedure grdDadosIntegracaoCombDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure grdPendenciasIntegracaoDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);

  private
    { Private declarations }
    FTipoCombustivel: string;
  public
    { Public declarations }


  end;

var
  IntegracaoFrm: TIntegracaoFrm;

implementation

uses
  InicialFrmU;

{$R *.dfm}


procedure TIntegracaoFrm.abaStatusIntegracaoShow(Sender: TObject);
begin
  grdPendenciasIntegracao.Hide;
  grdDadosIntegracaoComb.Hide;
end;

procedure TIntegracaoFrm.btnAtualizaStatusClick(Sender: TObject);
begin
  qryStatusIntegracao.Close;
  qryStatusIntegracao.Open;
  if qryStatusIntegracao.IsEmpty then
  begin
    lblSemPendencias.Show;
    lblPendencias.Hide;
    grdPendenciasIntegracao.Hide;
  end
  else
  begin
    lblPendencias.Show;
    grdPendenciasIntegracao.Show;
    lblSemPendencias.Hide;
  end;
end;

procedure TIntegracaoFrm.btnFiltrarIntegracaoClick(Sender: TObject);
var TipoCombustivel : string;

var DataInicial : TDate;
var DataInicialStr : string;

var DataFinal : TDate;
var DataFinalStr : string;

begin
  grdDadosIntegracaoComb.Show;
  qryValidaCombustiveis.Close;
  DataInicialStr := edtDataInicial.Text;
  DataFinalStr := edtDataFinal.Text;

  DataInicial := StrToDate(DataInicialStr);
  DataFinal := StrToDate(DataFinalStr);

  case rdgSelectComb.ItemIndex of
  0: TipoCombustivel := '312500018';
  1: TipoCombustivel := '312500025';
  2: TipoCombustivel := '312500060';
  end;

  qryValidaCombustiveis.ParamByName('DataInicial').AsDate := DataInicial;
  qryValidaCombustiveis.ParamByName('DataFinal').AsDate := DataFinal;
  qryValidaCombustiveis.ParamByName('TipoCombustivel').AsString := TipoCombustivel;
  qryValidaCombustiveis.Open;
end;

procedure TIntegracaoFrm.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TIntegracaoFrm.FormActivate(Sender: TObject);
begin
  abaStatusIntegracao.Show;
end;

procedure TIntegracaoFrm.grdDadosIntegracaoCombDrawColumnCell(Sender: TObject;
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
    grdDadosIntegracaoComb.Canvas.Brush.Color := LightGreen
  else
    grdDadosIntegracaoComb.Canvas.Brush.Color := LighterGreen;

  // Define a cor do texto
  grdDadosIntegracaoComb.Canvas.Font.Color := clBlack;
  if qryValidaCombustiveis.FieldByName('DIFERENCA').AsString <> '0' then
  begin
    grdDadosIntegracaoComb.Canvas.Brush.Color := clRed;
    grdDadosIntegracaoComb.Canvas.Font.Color := clWhite;
    grdDadosIntegracaoComb.Canvas.Font.Style := [fsBold];
  end;
  
  // Preenche o fundo da célula
  grdDadosIntegracaoComb.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TIntegracaoFrm.grdPendenciasIntegracaoDrawColumnCell(Sender: TObject;
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
    grdPendenciasIntegracao.Canvas.Brush.Color := LightGreen
  else
    grdPendenciasIntegracao.Canvas.Brush.Color := LighterGreen;

  // Define o estilo da fonte e cor do texto, se necessário
  grdPendenciasIntegracao.Canvas.Font.Style := [fsBold]; // Adiciona negrito, se desejado
  grdPendenciasIntegracao.Canvas.Font.Color := clBlack; // Cor do texto

  // Desenha a célula com as configurações definidas
  grdPendenciasIntegracao.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TIntegracaoFrm.pgcDadosIntegracaoChange(Sender: TObject);
var DataInicioMes : TDate;
var DataFimMes : TDate;
begin
  edtDataInicial.EditMask := '!99/99/9999;1;_';
  DataInicioMes := StartOfTheMonth(Date);
  edtDataInicial.Text := FormatDateTime('dd/mm/yyyy', DataInicioMes);

  edtDataFinal.EditMask := '!99/99/9999;1;_';
  DataFimMes := EndOfTheMonth(Date);
  edtDataFinal.Text := FormatDateTime('dd/mm/yyyy', DataFimMes);

end;


end.
