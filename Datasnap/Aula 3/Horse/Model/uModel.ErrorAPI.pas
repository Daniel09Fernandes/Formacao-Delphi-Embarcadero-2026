unit uModel.ErrorAPI;

interface

uses
  GBSwagger.Model.Attributes;

type
  TModelErrorApi = class
  private
    FMessage: string;

    procedure SetMessage(const Value: string);
  public
    [SwagProp('Message', true)]
    property &Message: string read FMessage write SetMessage;
  end;

implementation

{ TModelErrorApi }

procedure TModelErrorApi.SetMessage(const Value: string);
begin
  FMessage := 'Api Exception control: ' + Value;
end;

end.
