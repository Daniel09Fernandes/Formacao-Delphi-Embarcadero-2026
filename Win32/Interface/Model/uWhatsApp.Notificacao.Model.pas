unit uWhatsApp.Notificacao.Model;

interface

uses
  uNotificacao.Model.Interf,
  Vcl.Dialogs;

type
  TWhatsAppNoticacao = class(TInterfacedObject, INotificacao)
  private
    FNome: string;
  public
    function EnviarNotificacao(const ANotificacao: string): INotificacao;
    function ReceberNotificacao(const ANotificacao: string): INotificacao;

    procedure EnviarParaORemetente(ARemetente: string);

    class function New: INotificacao;
  end;

implementation

{ TWhatsAppNoticacao }

function TWhatsAppNoticacao.EnviarNotificacao(const ANotificacao: string): INotificacao;
begin
  ShowMessage('Notificação WhatsApp enviada: '+ ANotificacao);
  Result := Self;
end;

procedure TWhatsAppNoticacao.EnviarParaORemetente(ARemetente: string);
begin
  ShowMessage('Enviado o WhatsApp para o remetente: '+ ARemetente);
end;

class function TWhatsAppNoticacao.New: INotificacao;
begin
  Result := TWhatsAppNoticacao.Create;
end;

function TWhatsAppNoticacao.ReceberNotificacao(const ANotificacao: string): INotificacao;
begin
  ShowMessage('Notificação WhatsApp Recebida: '+ ANotificacao);
  Result := Self;
end;

end.
