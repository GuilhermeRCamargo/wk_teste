unit mCliente;

interface

type
  TCliente = class
  strict private
    fCodigo: integer;
    fNome: string;
    fCidade: string;
    fUF: string;
  public
    constructor Create;
    property Codigo: integer read fCodigo write fCodigo;
    property Nome: string read fNome write fNome;
    property Cidade: string read fCidade write fCidade;
    property UF: string read fUF write fUF;
  end;

implementation

uses System.SysUtils;

{ TCliente }

constructor TCliente.Create;
begin
  try
    fCodigo:= 0;
  except
    on e: exception do
      raise Exception.Create('[Create]'+e.Message);
  end;
end;


end.
