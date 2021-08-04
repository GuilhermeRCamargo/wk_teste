unit udmMain;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  mConfigBD, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TOnRefreshBDStatus = reference to procedure;
  TTipoOperacao = (toiInserir, toiAlterar);
  TdmMain = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  strict private
    fOnRefreshBDStatus: TOnRefreshBDStatus;
    const DATABASE_NAME: string = 'wk_test10';
  public
    function Conectar(AConfigBD: TConfigBD = nil): boolean;
    function GetQuery: TFDQuery;
    property OnRefreshBDStatus: TOnRefreshBDStatus read fOnRefreshBDStatus write fOnRefreshBDStatus;
  end;

var
  dmMain: TdmMain;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmMain }

function TdmMain.Conectar(AConfigBD: TConfigBD): boolean;
  function DBExists: boolean;
  var Qry: TFDQuery;
  begin
    Qry:= GetQuery;
    try
      try
        with Qry, sql do
        begin
          Clear;
          add('SELECT 1 FROM information_schema.schemata');
          add('WHERE schema_name = :schema_name');
          ParamByName('schema_name').AsString:= DATABASE_NAME;
          Open;
          result:= RecordCount > 0;
        end;
      except
        on e: exception do
          raise Exception.Create('[DBExists]'+e.Message);
      end;
    finally
      FreeAndNil(Qry);
    end;
  end;

  procedure CreateDB;
  var Qry: TFDQuery;
  begin
    Qry:= GetQuery;
    try
      try
        with Qry, sql do
        begin
          Clear;
          add('CREATE SCHEMA '+DATABASE_NAME);
          ExecSQL;
          Clear;
          add('USE '+DATABASE_NAME);
          ExecSQL;
          Clear;
          add('CREATE TABLE `'+DATABASE_NAME+'`.`tb_cliente` (');
          add('`codigo` INT NOT NULL AUTO_INCREMENT,');
          add('`nome` VARCHAR(80) NOT NULL,');
          add('`cidade` VARCHAR(50) NULL,');
          add('`uf` VARCHAR(2) NULL,');
          add('PRIMARY KEY (`codigo`))');
          ExecSQL;
          Clear;
          add('CREATE TABLE `'+DATABASE_NAME+'`.`tb_produto` (');
          add('`codigo` INT NOT NULL AUTO_INCREMENT,');
          add('`descricao` VARCHAR(120) NOT NULL,');
          add('`preco_venda` DOUBLE NULL,');
          add('PRIMARY KEY (`codigo`))');
          ExecSQL;
          Clear;
          add('CREATE TABLE `'+DATABASE_NAME+'`.`tb_pedido` (');
          add('`numero` INT NOT NULL AUTO_INCREMENT,');
          add('`data_emissao` DATETIME NOT NULL,');
          add('`codigo_cliente` INT NOT NULL,');
          add('`valor_total` DOUBLE NOT NULL,');
          add('PRIMARY KEY (`numero`),');
          add('INDEX `tb_pedido_codigo_cliente_fk_idx` (`codigo_cliente` ASC) VISIBLE,');
          add('CONSTRAINT `tb_pedido_codigo_cliente_fk`');
          add('FOREIGN KEY (`codigo_cliente`)');
          add('REFERENCES `'+DATABASE_NAME+'`.`tb_cliente` (`codigo`)');
          add('ON DELETE NO ACTION');
          add('ON UPDATE NO ACTION)');
          ExecSQL;
          Clear;
          add('CREATE TABLE `'+DATABASE_NAME+'`.`tb_pedido_item` (');
          add('`codigo` INT NOT NULL AUTO_INCREMENT,');
          add('`numero_pedido` INT NOT NULL,');
          add('`codigo_produto` INT NOT NULL,');
          add('`quantidade` DOUBLE NOT NULL,');
          add('`valor_unitario` DOUBLE NOT NULL,');
          add('`valor_total` DOUBLE NOT NULL,');
          add('PRIMARY KEY (`codigo`),');
          add('INDEX `tb_pedido_item_cod_pedido_idx` (`numero_pedido` ASC) VISIBLE,');
          add('INDEX `tb_pedido_item_cod_produto_idx` (`codigo_produto` ASC) VISIBLE,');
          add('CONSTRAINT `tb_pedido_item_num_pedido`');
          add('FOREIGN KEY (`numero_pedido`)');
          add('REFERENCES `'+DATABASE_NAME+'`.`tb_pedido` (`numero`)');
          add('ON DELETE NO ACTION');
          add('ON UPDATE NO ACTION,');
          add('CONSTRAINT `tb_pedido_item_cod_produto`');
          add('FOREIGN KEY (`codigo_produto`)');
          add('REFERENCES `'+DATABASE_NAME+'`.`tb_produto` (`codigo`)');
          add('ON DELETE NO ACTION');
          add('ON UPDATE NO ACTION)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Jonas Costa'', ''São Paulo'', ''SP'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Elias do Nascimento'', ''Salvador'', ''BA'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Roberto Silva'', ''São Paulo'', ''SP'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Maria Aparecida'', ''São Paulo'', ''SP'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Luis Carlos'', ''Rio de Janeiro'', ''RJ'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Guilherme Rocha'', ''Maringá'', ''PR'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Marcela Camargo'', ''Florianópolis'', ''SC'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Eloá Rocha'', ''Maringá'', ''PR'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Antonio Machado'', ''São Paulo'', ''SP'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Dmitri Koslovsky'', ''Fortaleza'', ''CE'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''João Paulo'', ''Nova Andradina'', ''MS'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Joserval Aquino'', ''São Luis'', ''MA'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Gabriel Monteiro'', ''Rio de Janeiro'', ''RJ'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Eliana Sabata'', ''Foz do Iguaçu'', ''PR'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Kaline Cruz'', ''São Roque'', ''SP'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''João Abreu'', ''Marialva'', ''PR'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Benedito Santos'', ''São Paulo'', ''SP'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Jorge Russo'', ''São Paulo'', ''SP'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Sebastião Viteli'', ''Curitiba'', ''PR'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Sergio Perez'', ''Blumenau'', ''SC'')');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_cliente` (`nome`, `cidade`, `uf`) VALUES (''Valter Botafogo'', ''Curitiba'', ''PR'')');
          ExecSQL;
          //Produtos
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Óleo de Coco 500ml'', 32.9)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Pasta de Amendoim 500g'', 20.64)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Azeitona Verde'', 12.9)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Tomate Seco'', 10.99)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Óleo de Algodão'', 320)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Rúcula'', 1.99)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Mandioca Congelada KG'', 4.99)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Alface Americana'', 1.99)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Castanha de Caju KG'', 80.9)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Ovos DZ'', 5.8)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Queijo Provolone KG'', 62)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Queijo Parmesão KG'', 90)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Aveia KG'', 6)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Cream Cheese'', 6.4)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Cenoura KG'', 2.90)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Grão-de-bico KG'', 12.9)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Massa para Tapioca'', 7.30)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Limão KG'', 2.9)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Laranja KG'', 1.33)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Cebola KG'', 3.1)');
          ExecSQL;
          Clear;
          add('INSERT INTO `'+DATABASE_NAME+'`.`tb_produto` (`descricao`, `preco_venda`) VALUES (''Arroz Integral KG'', 5.9)');
          ExecSQL;
        end;
      except
        on e: exception do
        begin
          FDConnection1.Connected:= False;
          raise Exception.Create('[CreateDB]'+e.Message);
        end;
      end;
    finally
      FreeAndNil(Qry);
    end;
  end;

begin
  try
    result:= false;
    if FDConnection1.Connected then
      FDConnection1.Connected:= false;
    if AConfigBD = nil then
    begin
      AConfigBD:= TConfigBD.Create;
      AConfigBD.CarregarConfig;
    end;
    with FDConnection1.Params do
    begin
      Clear;
      Add('DriverID=MySQL');
      Add('Server='+AConfigBD.Host);
      Add('Port='+IntToStr(AConfigBD.Porta));
//      Add('Database='+DATABASE_NAME);
      Add('User_Name='+AConfigBD.Usuario);
      Add('Password='+AConfigBD.Senha);
      try
        FDConnection1.Connected:= True;
        if FDConnection1.Connected then
        begin
          if DBExists then
          begin
            Add('Database='+DATABASE_NAME);
            FDConnection1.Connected:= False;
            FDConnection1.Connected:= True;
          end
          else
            CreateDB;
        end;
      finally
        result:= FDConnection1.Connected;
        if ASsigned(fOnRefreshBDStatus) then
          fOnRefreshBDStatus;
      end;
    end;
  except
    on e: exception do
      raise Exception.Create('[Conectar]'+e.Message);
  end;
end;


procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  try
    fOnRefreshBDStatus:= nil;
    Conectar();
  except

  end;
end;

function TdmMain.GetQuery: TFDQuery;
begin
  try
    result:= TFDQuery.Create(nil);
    result.Connection:= FDConnection1;
  except
    on e: exception do
      raise Exception.Create('[GetQuery]'+e.Message);
  end;
end;

end.
