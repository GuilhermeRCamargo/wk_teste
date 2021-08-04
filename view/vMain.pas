unit vMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.Mask, Vcl.StdCtrls,
  Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Vcl.DBCtrls, System.Actions, Vcl.ActnList, udmMain, mPedido;

type
  TFrmMain = class(TForm)
    Panel1: TPanel;
    pnlProduto: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    edtCodigoCliente: TEdit;
    lblCodigo: TLabel;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    mtItensPedido: TFDMemTable;
    mtItensPedidocodigo: TIntegerField;
    mtItensPedidocod_produto: TIntegerField;
    mtItensPedidodesc_produto: TStringField;
    mtItensPedidoquantidade: TFloatField;
    mtItensPedidovalor_unitario: TFloatField;
    dsItensPedido: TDataSource;
    butGravarPedido: TSpeedButton;
    butCarregarPedido: TSpeedButton;
    butCancelarPedido: TSpeedButton;
    Label2: TLabel;
    edtNomeCliente: TEdit;
    Label1: TLabel;
    edtCidadeUFCliente: TEdit;
    butConfigBD: TSpeedButton;
    Label6: TLabel;
    lblProduto: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtValorUnitario: TEdit;
    edtQuantidade: TEdit;
    edtCodProduto: TEdit;
    edtDescProduto: TEdit;
    Label3: TLabel;
    Panel5: TPanel;
    lblTotalPedido: TLabel;
    Panel6: TPanel;
    lblBDStatus: TLabel;
    butSalvarItem: TSpeedButton;
    ActionList1: TActionList;
    actSalvarItem: TAction;
    mtItensPedidototal: TFloatField;
    mtItensPedidototal_agg: TAggregateField;
    actGravarPedido: TAction;
    actCarregarPedido: TAction;
    actCancelarPedido: TAction;
    actConfiguracoes: TAction;
    Panel2: TPanel;
    Label4: TLabel;
    lblNumero: TLabel;
    Label11: TLabel;
    lblDataEmissao: TLabel;
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure edtCodigoClienteChange(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure actSalvarItemExecute(Sender: TObject);
    procedure mtItensPedidoCalcFields(DataSet: TDataSet);
    procedure mtItensPedidoAfterPost(DataSet: TDataSet);
    procedure Panel4Enter(Sender: TObject);
    procedure pnlProdutoEnter(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Panel1Enter(Sender: TObject);
    procedure pnlProdutoExit(Sender: TObject);
    procedure actCarregarPedidoExecute(Sender: TObject);
    procedure actGravarPedidoExecute(Sender: TObject);
    procedure actCancelarPedidoExecute(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure actConfiguracoesExecute(Sender: TObject);
  strict private
    fTipoOperacaoItemAtual: TTipoOperacao;
    const LABEL_INSERIR_ITEM: string = 'Produto';
    const LABEL_EDITAR_ITEM: string = 'Editando Item';
    const LABEL_SALVAR_EDICAO_ITEM: string = 'Alterar [F5]';
    const LABEL_SALVAR_INSERIR_ITEM: string = 'Inserir Item [F5]';

    procedure LimparUI;
    procedure PedidoToUI(APedido: TPedido);
    function UIToPedido: TPedido;
    procedure RefreshBDStatus;
    procedure RefreshTotalPedido;
    function SalvarItem(const ATipoOperacaoItem: TTipoOperacao): boolean;
    procedure SetTipoOperacaoItemAtual(const ATipoOperacaoItem: TTipoOperacao);
    function StringToFloat(const AValue: string): Double;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property TipoOperacaoItemAtual: TTipoOperacao read fTipoOperacaoItemAtual write SetTipoOperacaoItemAtual;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses vConfigBD, mCliente, mProduto, cPedido, vGetCodigoPedido, dPedido,
  dCliente, dProduto;

function TFrmMain.SalvarItem(const ATipoOperacaoItem: TTipoOperacao): boolean;
var APedidoItem: TPedidoItem;
begin
  try
    result:= false;
    APedidoItem:= TPedidoItem.Create;
    try
      APedidoItem.Produto.Codigo:= StrToIntDef(edtCodProduto.Text, 0);
      APedidoItem.Quantidade:= StringToFloat(edtQuantidade.Text);
      APedidoItem.ValorUnitario:= StringToFloat(edtValorUnitario.Text);
      if APedidoItem.ValidarNovoItem then
      begin
        with mtItensPedido do
        begin
          if ATipoOperacaoItem = toiInserir then
          begin
            Append;
            FieldByName('cod_produto').AsInteger:= APedidoItem.Produto.Codigo;
            FieldByName('desc_produto').AsString:= edtDescProduto.Text;
          end
          else
            Edit;
          FieldByName('quantidade').AsFloat:= APedidoItem.Quantidade;
          FieldByName('valor_unitario').AsFloat:= APedidoItem.ValorUnitario;
          Post;
          result:= true;
        end;
      end;
    finally
      FreeAndNil(APedidoItem);
    end;
  except
    on e: exception do
      raise Exception.Create('[SalvarItem]'+e.Message);
  end;
end;

procedure TFrmMain.mtItensPedidoAfterPost(DataSet: TDataSet);
begin
  RefreshTotalPedido;
end;

procedure TFrmMain.mtItensPedidoCalcFields(DataSet: TDataSet);
begin
  try
    with mtItensPedido do
      FieldByName('total').AsFloat:= FieldByName('quantidade').AsFloat*FieldByName('valor_unitario').AsFloat;
  except
    on e: exception do
      raise Exception.Create('[mtItensPedidoCalcFields]'+e.Message);
  end;
end;

procedure TFrmMain.Panel1Enter(Sender: TObject);
begin
  if edtCodigoCliente.CanFocus then
    edtCodigoCliente.SetFocus;
end;

procedure TFrmMain.pnlProdutoEnter(Sender: TObject);
begin
  if edtCodProduto.CanFocus then
    edtCodProduto.SetFocus;
end;

procedure TFrmMain.pnlProdutoExit(Sender: TObject);
begin
  try
    if TipoOperacaoItemAtual = toiAlterar then
    begin
      if Application.MessageBox('Deseja salvar as alterações no item?', 'WK', mb_yesno+mb_iconquestion) = idYes then
        actSalvarItemExecute(Sender)
      else
        TipoOperacaoItemAtual:= toiInserir;
    end;
  except
    on e: exception do
      raise Exception.Create('[pnlProdutoExit]'+e.Message);
  end;
end;

procedure TFrmMain.Panel4Enter(Sender: TObject);
begin
  DBGrid1.SetFocus;
end;

procedure TFrmMain.PedidoToUI(APedido: TPedido);
var AItem: TPedidoItem;
begin
  try
    lblNumero.Caption:= IntToStr(APedido.Numero);
    lblDataEmissao.Caption:= FormatDateTime('dd/mm/yyyy', APedido.Emissao);
    edtCodigoCliente.Text:= IntToStr(APedido.Cliente.Codigo);
    edtNomeCliente.Text:= APedido.Cliente.Nome;
    edtCidadeUFCliente.Text:= APedido.Cliente.Cidade+'/'+APedido.Cliente.UF;
    mtItensPedido.DisableControls;
    try
      with mtItensPedido do
      begin
        EmptyDataSet;
        for AItem in APedido.Items do
        begin
          Append;
          FieldByName('cod_produto').AsInteger:= AItem.Produto.Codigo;
          FieldByName('desc_produto').ASString:= AItem.Produto.Descricao;
          FieldByName('quantidade').AsFloat:= AItem.Quantidade;
          FieldByName('valor_unitario').AsFloat:= AItem.ValorUnitario;
          Post;
        end;
      end;
    finally
      mtItensPedido.EnableControls
    end;
  except
    on e: exception do
      raise Exception.Create('[PedidoToUI]'+e.Message);
  end;
end;

procedure TFrmMain.actCancelarPedidoExecute(Sender: TObject);
var APedido: TPedido;
    ANumero: integer;
begin
  if butCancelarPedido.Enabled then
    try
      ANumero:= GetNumeroPedido;
      if ANumero > 0 then
        if not (TPedidoDAO.PedidoExiste(ANumero)) then
          Application.MessageBox(PWideChar('O pedido Nº '+IntToStr(ANumero)+' não existe!'),
           'WK', mb_ok+mb_iconinformation)
        else
        begin
          APedido:= TPedidoDAO.Carregar(ANumero);
          PedidoToUI(APedido);
          if Application.MessageBox(PWideChar('Deseja cancelar o pedido Nº '+IntToStr(ANumero)+'?'),
           'WK', mb_yesno+mb_iconinformation) = idYes then
          begin
            if TPedidoDAO.Excluir(ANumero) then
              ShowMessage('Pedido cancelado com sucesso!')
            else
              ShowMessage('Houve um erro ao cancelar o pedido.');
            LimparUI;
          end;
        end;
    except
      on e: exception do
        raise Exception.Create('[actCarregarPedidoExecute]'+e.Message);
    end;
end;

procedure TFrmMain.actCarregarPedidoExecute(Sender: TObject);
var APedido: TPedido;
    ANumero: integer;
begin
  if butCarregarPedido.Enabled then
    try
      ANumero:= GetNumeroPedido;
      if ANumero > 0 then
        if not (TPedidoDAO.PedidoExiste(ANumero)) then
          Application.MessageBox(PWideChar('O pedido Nº '+IntToStr(ANumero)+' não existe!'),
           'WK', mb_ok+mb_iconinformation)
        else
        begin
          APedido:= TPedidoDAO.Carregar(ANumero);
          PedidoToUI(APedido);
        end;
    except
      on e: exception do
        raise Exception.Create('[actCarregarPedidoExecute]'+e.Message);
    end;
end;

procedure TFrmMain.actConfiguracoesExecute(Sender: TObject);
begin
  try
    if Assigned(FrmConfigBD) then
      FreeAndNil(FrmConfigBD);
    FrmConfigBD:= TFrmConfigBD.Create(Application);
    FrmConfigBD.ShowModal;
  except
    on e: exception do
      raise Exception.Create('[actConfiguracoesExecute]'+e.Message);
  end;
end;

procedure TFrmMain.actGravarPedidoExecute(Sender: TObject);
var APedido: TPedido;
begin
  if butGravarPedido.Enabled then
    try
      ActiveControl:= nil;
      APedido:= UIToPedido;
      try
        if TPedidoController.Salvar(APedido) then
        begin
          Application.MessageBox(PWideChar('Pedido Nº '+IntToStr(APedido.Numero)+' salvo com sucesso!'),
           'WK', mb_ok+mb_iconinformation);
          LimparUI;
          if edtCodigoCliente.CanFocus then
            edtCodigoCliente.SetFocus;
        end;
      finally
        FreeAndNil(APedido);
      end;
    except
      on e: exception do
        raise Exception.Create('[actGravarPedidoExecute]'+e.Message);
    end;
end;

procedure TFrmMain.actSalvarItemExecute(Sender: TObject);
begin
  try
    if SalvarItem(TipoOperacaoItemAtual) then
    begin
      EdtCodProduto.Text:= '';
      edtDescProduto.Text:= '';
      edtQuantidade.Text:= '';
      edtValorUnitario.Text:= '';
      if TipoOperacaoItemAtual = toiAlterar then
        TipoOperacaoItemAtual:= toiInserir;
      if EdtCodProduto.CanFocus then
        edtCodProduto.SetFocus;
    end;
  except
    on e: exception do
      raise Exception.Create('[actSalvarItemExecute]'+e.Message);
  end;
end;

constructor TFrmMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  try
    RefreshBDStatus;
    dmMain.OnRefreshBDStatus:= RefreshBDStatus;
    mtItensPedido.CreateDataSet;
  except
    on e: exception do
      raise Exception.Create('[Create]'+e.Message);
  end;
end;

procedure TFrmMain.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  try
    if Key = VK_RETURN then
    begin
      if (mtItensPedido.RecordCount > 0) then
        TipoOperacaoItemAtual:= toiAlterar;
    end
    else
      if Key = VK_DELETE then
        if (mtItensPedido.RecordCount > 0) then
          if Application.MessageBox('Deseja excluir o item selecionado?', 'WK', mb_yesno+mb_iconquestion) = idYes then
            mtItensPedido.Delete;
  except
    on e: exception do
      raise Exception.Create('[DBGrid1KeyDown]'+e.Message);
  end;
end;

procedure TFrmMain.edtCodigoClienteChange(Sender: TObject);
begin
  try
    butGravarPedido.Enabled:= StrToIntDef(edtCodigoCliente.Text, 0) > 0;
    butCarregarPedido.Enabled:= Trim(edtCodigoCliente.Text) = '';
    butCAncelarPedido.Enabled:= Trim(edtCodigoCliente.Text) = '';
  except
    on e: exception do
      raise Exception.Create('[edtCodigoClienteChange]'+e.Message);
  end;
end;

procedure TFrmMain.edtCodigoClienteExit(Sender: TObject);
var ACliente: TCliente;
begin
  try
    if StrToIntDef(EdtCodigoCliente.Text, 0) <= 0 then
      ACliente:= TCliente.Create
    else
    begin
      ACliente:= TClienteDAO.Carregar(StrToIntDef(EdtCodigoCliente.Text, 0));
      if ACliente.Codigo <= 0 then
        Application.MessageBox('Cliente não encontrado', 'WK', mb_ok+mb_iconinformation);
    end;
    try
      if ACliente.Codigo <= 0 then
      begin
        edtCodigoCliente.Text:= '';
        edtCidadeUFCliente.Text:= '';
      end
      else
        edtCidadeUFCliente.Text:= ACliente.Cidade+'/'+ACliente.UF;
      edtNomeCliente.Text:= ACliente.Nome;
    finally
      FreeAndNil(ACliente);
    end;
  except
    on e: exception do
      raise Exception.Create('[edtCodigoClienteExit]'+e.Message);
  end;
end;

procedure TFrmMain.edtCodProdutoExit(Sender: TObject);
var AProduto: TProduto;
begin
  try
    if StrToIntDef(EdtCodProduto.Text, 0) <= 0 then
      AProduto:= TProduto.Create
    else
    begin
      AProduto:= TProdutoDAO.Carregar(StrToIntDef(EdtCodProduto.Text, 0));
      if AProduto.Codigo <= 0 then
        Application.MessageBox('Produto não encontrado', 'WK', mb_ok+mb_iconinformation);
    end;
    try
      if AProduto.Codigo <= 0 then
      begin
        EdtCodProduto.Text:= '';
        edtQuantidade.Text:= '';
        edtValorUnitario.Text:= '';
      end
      else
      begin
        edtQuantidade.Text:= '1';
        edtValorUnitario.Text:= FormatFloat('#,##0.00', AProduto.PrecoVenda);
      end;
      edtDescProduto.Text:= AProduto.Descricao;
    finally
      FreeAndNil(AProduto);
    end;
  except
    on e: exception do
      raise Exception.Create('[edtCodProdutoExit]'+e.Message);
  end;
end;

procedure TFrmMain.edtQuantidadeExit(Sender: TObject);
begin
  if Sender is TEdit then
    TEdit(Sender).Text:= FormatFloat('#,##0.00', StringToFloat(TEdit(Sender).Text));
end;


procedure TFrmMain.LimparUI;
begin
  try
    lblNumero.Caption:= '';
    lblDataEmissao.Caption:= '';
    edtCodigoCliente.Text:= '';
    edtNomeCliente.Text:= '';
    edtCidadeUFCliente.Text:= '';
    edtCodProduto.Text:= '';
    edtDescProduto.TexT:= '';
    edtQuantidade.Text:= '';
    edtValorUnitario.Text:= '';
    mtItensPedido.EmptyDataSet;
    RefreshTotalPedido;
  except
    on e: exception do
      raise Exception.Create('[LimparUI]'+e.Message);
  end;
end;

procedure TFrmMain.RefreshBDStatus;
begin
  try
    if dmMain.FDConnection1.Connected then
    begin
      lblBDStatus.Caption:= 'Conectado na base dados';
      lblBDStatus.Font.Color:= clGreen;
    end
    else
    begin
      lblBDStatus.Caption:= 'Desconectado da base dados';
      lblBDStatus.Font.Color:= clMaroon;
    end;
  except
    on e: exception do
      raise Exception.Create('[RefreshBDStatus]'+e.Message);
  end;
end;

procedure TFrmMain.RefreshTotalPedido;
var AMT: TFDMemTAble;
    d: Double;
begin
  d:= StringToFloat(mtItensPedido.FieldByName('total_agg').AsString);
  lblTotalPedido.Caption:= 'Valor Total: '+FormatFloat('#,##0.00', d);
end;

procedure TFrmMain.SetTipoOperacaoItemAtual(
  const ATipoOperacaoItem: TTipoOperacao);
begin
  try
    fTipoOperacaoItemAtual:= ATipoOperacaoItem;
    with mtItensPedido do
    begin
      if fTipoOperacaoItemAtual = toiAlterar then
      begin
        lblProduto.Caption:= LABEL_EDITAR_ITEM;
        lblProduto.Font.Color:= clMaroon;
        butSalvarItem.Caption:= LABEL_SALVAR_EDICAO_ITEM;
        butSalvarItem.Font.Color:= clMaroon;
        edtCodProduto.Text:= FieldByName('cod_produto').AsString;
        edtDescProduto.Text:= FieldByName('desc_produto').AsString;
        edtQuantidade.Text:= FormatFloat('#,##0.00', FieldByName('quantidade').AsFloat);
        edtValorUnitario.Text:= FormatFloat('#,##0.00', FieldByName('valor_unitario').AsFloat);
        edtCodProduto.Enabled:= False;
        edtDescProduto.Enabled:= False;
        edtQuantidade.SetFocus;
      end
      else
      begin
        lblProduto.Caption:= LABEL_INSERIR_ITEM;
        lblProduto.Font.Color:= clBlack;
        butSalvarItem.Caption:= LABEL_SALVAR_INSERIR_ITEM;
        butSalvarItem.Font.Color:= clBlack;
        edtCodProduto.Text:= '';
        edtDescProduto.Text:= '';
        edtQuantidade.Text:= '';
        edtValorUnitario.Text:= '';
        edtCodProduto.Enabled:= True;
        edtDescProduto.Enabled:= True;
      end;
    end;
  except
    on e: exception do
      raise Exception.Create('[SetTipoOperacaoItemAtual]'+e.Message);
  end;
end;

function TFrmMain.StringToFloat(const AValue: string): Double;
var i: integer;
    s: string;
begin
  try
    s:= StringReplace(AValue, FormatSettings.ThousandSeparator, '', [rfReplaceAll]);
    result:= StrToFloatDef(s, 0);
  except
    result:= 0;
  end;
end;

function TFrmMain.UIToPedido: TPedido;
begin
  try
    result:= TPedido.Create;
    result.Numero:= StrToIntDef(lblNumero.Caption, 0);
    result.Emissao:= StrToDateTimeDef(lblDataEmissao.Caption, 0);
    result.Cliente.Codigo:= StrToIntDef(edtCodigoCliente.Text, 0);
    mtItensPedido.DisableControls;
    try
      with mtItensPedido do
      begin
        First;
        while not (Eof) do
        begin
          Result.Items.Add(TPedidoItem.Create);
          Result.Items.Last.Produto.Codigo:= mtItensPedido.FieldByName('cod_produto').AsInteger;
          Result.Items.Last.Produto.Descricao:= mtItensPedido.FieldByName('desc_produto').ASString;
          Result.Items.Last.Quantidade:= mtItensPedido.FieldByName('quantidade').AsFloat;
          Result.Items.Last.ValorUnitario:= mtItensPedido.FieldByName('valor_unitario').AsFloat;
          mtItensPedido.Next;
        end;
      end;
    finally
      mtItensPedido.EnableControls
    end;

  except
    on e: exception do
      raise Exception.Create('[UIToPedido]'+e.Message);
  end;
end;

end.
