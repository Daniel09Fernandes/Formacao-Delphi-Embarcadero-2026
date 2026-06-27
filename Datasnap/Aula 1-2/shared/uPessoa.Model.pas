unit uPessoa.Model;

interface
uses
  Generics.Collections;

type

  TPessoa = class
  private
    FID: Integer;
    FNome: string;
    FDataNascimento: TDateTime;
    FRenda: Currency;
    FAtivo: Boolean;
  public
    property ID: Integer read FID write FID;
    property Nome: string read FNome write FNome;
    property DataNascimento: TDateTime read FDataNascimento
      write FDataNascimento;
    property Renda: Currency read FRenda write FRenda;
    property Ativo: Boolean read FAtivo write FAtivo;
  end;

  TListaPessoa = TObjectList<TPessoa>;
implementation

end.
