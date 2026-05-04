unit Model.DTO_Clientes;

interface

uses
  Model.Attributes;

type
  [TTabela('Clientes')]
  TClientes_DTO = class
  private
    FId: Integer;
    FNome: string;
    FIgnore: Boolean;
  public
    [TField('ID'), TPK, TAutoInc]
    property ID  : Integer read FId   write FId;
    [TField('Nome')]
    property Nome: string  read FNome write FNome;
    [TIgnore]
    property Ignore: Boolean read FIgnore write FIgnore;
  end;

implementation

end.
