unit uCliente.Model;

interface

{$M+}

uses
  uDBMapping.Attributes,
  System.Generics.Collections;

type
  [TMappingTable('tab_clientes')]
  TClientes = class
  private
    FId: Integer;
    FNome: string;
    FIdade: Integer;
    FCpfCnpj: string;
    FFisJur: string;
    FEndereco: string;
    FBairro: string;
    FCidade: string;
    function GetFisJur: string;
  public
    [TMappingDisplayGrid('Cód')]
    [TMappingField('ID', 4)]
    property Id: Integer read FId write FId;
    [TMappingField('Nome')]
    property Nome: string read FNome write FNome;
    [TMappingField('Idade')]
    property Idade: Integer read FIdade write FIdade;
    [TMappingDisplayGrid('CPF ou CNPJ')]
    [TMappingField('CPF_CNPJ')]
    property CpfCnpj: string read FCpfCnpj write FCpfCnpj;
    [TMappingDisplayGrid('P. Fisica ou Juridica')]
    [TMappingField('FISJUR')]
    property FisJur: string read GetFisJur write FFisJur;
    [TMappingDisplayGrid('Endereço')]
    [TMappingField('Endereco')]
    property Endereco: string read FEndereco write FEndereco;
    [TMappingField('Bairro')]
    property Bairro: string read FBairro write FBairro;
    [TMappingField('Cidade')]
    property Cidade: string read FCidade write FCidade;
  end;

  TListaClientes = TObjectList<TClientes>;
implementation

{ TClientes }

function TClientes.GetFisJur: string;
begin
  Result := '';

  if FFisJur = 'F' then
    Result := 'Fisica'
  else
    if FFisJur = 'J' then
      Result := 'Juridica';
end;

end.
