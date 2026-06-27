unit uBitcoin.Api.Model;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TOutputs = class(TJsonDTO)
  private
    [JSONName('addresses')]
    FAddressesArray: TArray<string>;
    [JSONMarshalled(False)]
    FAddresses: TList<string>;
    [JSONName('script')]
    FScript: string;
    [JSONName('script_type')]
    FScriptType: string;
    [JSONName('spent_by')]
    FSpentBy: string;
    [JSONName('value')]
    FValue: Int64;
    function GetAddresses: TList<string>;
  protected
    function GetAsJson: string; override;
  published
    property Addresses: TList<string> read GetAddresses;
    property Script: string read FScript write FScript;
    property ScriptType: string read FScriptType write FScriptType;
    property SpentBy: string read FSpentBy write FSpentBy;
    property Value: Int64 read FValue write FValue;
  public
    destructor Destroy; override;
  end;

  TInputs = class(TJsonDTO)
  private
    [JSONName('addresses')]
    FAddressesArray: TArray<string>;
    [JSONMarshalled(False)]
    FAddresses: TList<string>;
    [JSONName('age')]
    FAge: Integer;
    [JSONName('output_index')]
    FOutputIndex: Integer;
    [JSONName('output_value')]
    FOutputValue: Integer;
    [JSONName('prev_hash')]
    FPrevHash: string;
    [JSONName('script')]
    FScript: string;
    [JSONName('script_type')]
    FScriptType: string;
    [JSONName('sequence')]
    FSequence: Int64;
    function GetAddresses: TList<string>;
  protected
    function GetAsJson: string; override;
  published
    property Addresses: TList<string> read GetAddresses;
    property Age: Integer read FAge write FAge;
    property OutputIndex: Integer read FOutputIndex write FOutputIndex;
    property OutputValue: Integer read FOutputValue write FOutputValue;
    property PrevHash: string read FPrevHash write FPrevHash;
    property Script: string read FScript write FScript;
    property ScriptType: string read FScriptType write FScriptType;
    property Sequence: Int64 read FSequence write FSequence;
  public
    destructor Destroy; override;
  end;

  TBitcoinModel = class(TJsonDTO)
  private
    [JSONName('addresses')]
    FAddressesArray: TArray<string>;
    [JSONMarshalled(False)]
    FAddresses: TList<string>;
    [JSONName('block_hash')]
    FBlockHash: string;
    [JSONName('block_height')]
    FBlockHeight: Integer;
    [JSONName('block_index')]
    FBlockIndex: Integer;
    [JSONName('confidence')]
    FConfidence: Integer;
    [JSONName('confirmations')]
    FConfirmations: Integer;
    [SuppressZero, JSONName('confirmed')]
    FConfirmed: TDateTime;
    [JSONName('double_spend')]
    FDoubleSpend: Boolean;
    [JSONName('fees')]
    FFees: Integer;
    [JSONName('hash')]
    FHash: string;
    [JSONName('inputs'), JSONMarshalled(False)]
    FInputsArray: TArray<TInputs>;
    [GenericListReflect]
    FInputs: TObjectList<TInputs>;
    [JSONName('outputs'), JSONMarshalled(False)]
    FOutputsArray: TArray<TOutputs>;
    [GenericListReflect]
    FOutputs: TObjectList<TOutputs>;
    [JSONName('preference')]
    FPreference: string;
    [SuppressZero, JSONName('received')]
    FReceived: TDateTime;
    [JSONName('size')]
    FSize: Integer;
    [JSONName('total')]
    FTotal: Int64;
    [JSONName('ver')]
    FVer: Integer;
    [JSONName('vin_sz')]
    FVinSz: Integer;
    [JSONName('vout_sz')]
    FVoutSz: Integer;
    [JSONName('vsize')]
    FVsize: Integer;
    function GetAddresses: TList<string>;
    function GetInputs: TObjectList<TInputs>;
    function GetOutputs: TObjectList<TOutputs>;
  protected
    function GetAsJson: string; override;
  published
    property Addresses: TList<string> read GetAddresses;
    property BlockHash: string read FBlockHash write FBlockHash;
    property BlockHeight: Integer read FBlockHeight write FBlockHeight;
    property BlockIndex: Integer read FBlockIndex write FBlockIndex;
    property Confidence: Integer read FConfidence write FConfidence;
    property Confirmations: Integer read FConfirmations write FConfirmations;
    property Confirmed: TDateTime read FConfirmed write FConfirmed;
    property DoubleSpend: Boolean read FDoubleSpend write FDoubleSpend;
    property Fees: Integer read FFees write FFees;
    property Hash: string read FHash write FHash;
    property Inputs: TObjectList<TInputs> read GetInputs;
    property Outputs: TObjectList<TOutputs> read GetOutputs;
    property Preference: string read FPreference write FPreference;
    property Received: TDateTime read FReceived write FReceived;
    property Size: Integer read FSize write FSize;
    property Total: Int64 read FTotal write FTotal;
    property Ver: Integer read FVer write FVer;
    property VinSz: Integer read FVinSz write FVinSz;
    property VoutSz: Integer read FVoutSz write FVoutSz;
    property Vsize: Integer read FVsize write FVsize;
  public
    destructor Destroy; override;
  end;

implementation

{ TOutputs }

destructor TOutputs.Destroy;
begin
  GetAddresses.Free;
  inherited;
end;

function TOutputs.GetAddresses: TList<string>;
begin
  Result := List<string>(FAddresses, FAddressesArray);
end;

function TOutputs.GetAsJson: string;
begin
  RefreshArray<string>(FAddresses, FAddressesArray);
  Result := inherited;
end;

{ TInputs }

destructor TInputs.Destroy;
begin
  GetAddresses.Free;
  inherited;
end;

function TInputs.GetAddresses: TList<string>;
begin
  Result := List<string>(FAddresses, FAddressesArray);
end;

function TInputs.GetAsJson: string;
begin
  RefreshArray<string>(FAddresses, FAddressesArray);
  Result := inherited;
end;

{ TBitCoinModel }

destructor TBitCoinModel.Destroy;
begin
  GetAddresses.Free;
  GetInputs.Free;
  GetOutputs.Free;
  inherited;
end;

function TBitCoinModel.GetAddresses: TList<string>;
begin
  Result := List<string>(FAddresses, FAddressesArray);
end;

function TBitCoinModel.GetInputs: TObjectList<TInputs>;
begin
  Result := ObjectList<TInputs>(FInputs, FInputsArray);
end;

function TBitCoinModel.GetOutputs: TObjectList<TOutputs>;
begin
  Result := ObjectList<TOutputs>(FOutputs, FOutputsArray);
end;

function TBitCoinModel.GetAsJson: string;
begin
  RefreshArray<string>(FAddresses, FAddressesArray);
  RefreshArray<TInputs>(FInputs, FInputsArray);
  RefreshArray<TOutputs>(FOutputs, FOutputsArray);
  Result := inherited;
end;

end.
