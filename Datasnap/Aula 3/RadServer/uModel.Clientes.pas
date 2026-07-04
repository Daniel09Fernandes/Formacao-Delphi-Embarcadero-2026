unit uModel.Clientes;

interface
  {
    "id": 1,
    "nome": "Daniel Fernandes",
    "idade": 33,
    "cpfCnpj": "123455",
    "fisjur": "Fisica",
    "endereco": "Rua 1",
    "bairro": "Centro",
    "cidade": "SP"
  }
type
  TClientesModel = class
  private
    FId: string;
    Fnome: string;
    Fidade: Integer;
    FcpfCnpj: string;
    Ffisjur: string;
    Fendereco: string;
    Fbairro: string;
    Fcidade: string;

  public
    property Id: string read FId write FId;
    property nome: string read Fnome write Fnome;
    property idade: Integer read Fidade write Fidade;
    property cpfCnpj: string read FcpfCnpj write FcpfCnpj;
    property fisjur: string read Ffisjur write Ffisjur;
    property endereco: string read Fendereco write Fendereco;
    property bairro: string read Fbairro write Fbairro;
    property cidade: string read Fcidade write Fcidade;
  end;

implementation

end.
