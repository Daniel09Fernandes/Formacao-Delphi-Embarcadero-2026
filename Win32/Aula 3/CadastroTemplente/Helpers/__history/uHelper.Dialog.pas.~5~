unit uHelper.Dialog;

interface

uses
  uDialog, FMX.Forms;

type
  TDlgType = TDialogType;

  TFormHelper = class helper for TForm
    function ShowMessage(AMsg: string;  ADlgType: TDialogType = dInfo): Boolean;
  end;

implementation

{ TFormHelper }

function TFormHelper.ShowMessage(AMsg: string; ADlgType: TDialogType): Boolean;
begin
  Result := TFrDialog.ShowMessage(AMsg, ADlgType);
end;

end.
