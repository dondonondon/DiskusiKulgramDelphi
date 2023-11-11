unit frHome;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.ListBox, FMX.Effects,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uK2SQL, System.Rtti,
  FMX.Grid.Style, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, FMX.ScrollBox, FMX.Grid, System.DateUtils,
  System.Generics.Collections, System.NetEncoding, System.Threading;

type
  TFHome = class(TFrame)
    background: TRectangle;
    loMain: TLayout;
    loHeader: TLayout;
    reHeader: TRectangle;
    seHeader: TShadowEffect;
    lbData: TListBox;
    loTemp: TLayout;
    reTempBackground: TRectangle;
    reTempImage: TRectangle;
    lblTempNama: TLabel;
    lblTempHarga: TLabel;
    lblTempDesk: TLabel;
    seTemp: TShadowEffect;
    QProduct: TK2SQL;
    memProduct: TFDMemTable;
    CornerButton1: TCornerButton;
    QDownload: TK2SQL;
    memDownload: TFDMemTable;
    AniIndicator1: TAniIndicator;
    procedure QProductErroRequest(Sender: TObject);
    procedure QProductBeforeOpen(Sender: TObject);
    procedure QProductAfterOpen(Sender: TObject);
    procedure CornerButton1Click(Sender: TObject);
    procedure lbDataItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private
//    FListImage : TList<TRectangle>;

    procedure AddItem(FIndex : Integer; FNama, FDeskripsi, FHarga, FImage : String);

    procedure DownloadGambarBase64(IDProduct : String);

    procedure DecodeBase64(FData, FFileName : String);

    procedure LoadItem;
  public
    { Public declarations }
  published
    constructor Create(AOwner : TComponent); override;
  end;

var FHome : TFHome;

implementation

{$R *.fmx}

uses uDM;

procedure TFHome.AddItem(FIndex: Integer; FNama, FDeskripsi, FHarga,
  FImage: String);
begin
  var lb := TListBoxItem.Create(lbData);
  lb.Selectable := False;
  lb.Height := loTemp.Height + 8;
  lb.Width := lbData.Width / lbData.Columns;

  lb.Tag := FIndex;

  var lo := TLayout(loTemp.Clone(lb));
  lo.Width := lb.Width - 8;

  lo.Position.X := 4;
  lo.Position.Y := 4;

  lo.Visible := True;

  TLabel(lo.FindStyleResource(lblTempNama.StyleName)).Text := FNama;
  TLabel(lo.FindStyleResource(lblTempHarga.StyleName)).Text := FHarga;
  TLabel(lo.FindStyleResource(lblTempDesk.StyleName)).Text := FDeskripsi;

  TRectangle(lo.FindStyleResource(reTempImage.StyleName)).Hint := FImage;

  if FileExists(FImage) then
    TRectangle(lo.FindStyleResource(reTempImage.StyleName)).Fill.Bitmap.Bitmap.LoadFromFile(FImage);

  lb.AddObject(lo);
  lbData.AddObject(lb);
end;

procedure TFHome.CornerButton1Click(Sender: TObject);
begin
  lbData.Items.Clear;
//  TTask.Run(procedure begin
    LoadItem;
//  end).Start;
end;

constructor TFHome.Create(AOwner: TComponent);
begin
  inherited;

  loTemp.Visible := False;
end;

procedure TFHome.DecodeBase64(FData, FFileName: String);
begin
  var Stream := TMemoryStream.Create;
  var StreamOutput := TStringStream.Create;
  var SL := TStringList.Create;
  try
    SL.Text := FData;
    SL.SaveToStream(Stream);
    Stream.Position := 0;

    TNetEncoding.Base64.Decode(Stream, StreamOutput);
    StreamOutput.Position := 0;
    StreamOutput.SaveToFile(FFileName);
//    Image1.Bitmap.LoadFromStream(StreamOutput);
  finally
    SL.DisposeOf;
    Stream.DisposeOf;
    StreamOutput.DisposeOf;
  end;
end;

procedure TFHome.DownloadGambarBase64(IDProduct: String);
begin
  var FDateTime : TDateTime;
  var SQLAdd : String;
  SQLAdd := 'select image, UNIX_TIMESTAMP(udt) udt FROM product where product = ' + QuotedStr(IDProduct);
  QDownload.SQL.Text := SQLAdd;
  QDownload.Open;

  FDateTime := UnixToDateTime(StrToInt64Def(memProduct.FieldByName('udt').AsString, 1699708760));

  DecodeBase64(
    memDownload.FieldByName('image').AsString,
    memProduct.FieldByName('product').AsString +
      FormatDateTime('yyyymmddhhnnss', FDateTime) + '.jpg'
  );
end;

procedure TFHome.lbDataItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  memProduct.RecNo := Item.Tag;

  ShowMessage(memProduct.FieldByName('name').AsString);
end;

procedure TFHome.LoadItem;
begin
  var FDateTime : TDateTime;
  var SQLAdd, FFileName : String;
  SQLAdd := 'select product, UNIX_TIMESTAMP(udt) udt, name, product.desc, price FROM product';
  QProduct.SQL.Text := SQLAdd;
  QProduct.Open(True);

//  for var i := 0 to memProduct.RecordCount - 1 do begin
//    FDateTime := UnixToDateTime(StrToInt64Def(memProduct.FieldByName('udt').AsString, 1699708760));
//    FFileName := memProduct.FieldByName('product').AsString + FormatDateTime('yyyymmddhhnnss', FDateTime) + '.jpg';
//
//    if not FileExists(FFileName) then
//      DownloadGambarBase64(memProduct.FieldByName('product').AsString);
//
//    memProduct.Next;
//  end;
//
//
//  TThread.Synchronize(nil, procedure begin
//
//    memProduct.First;
//
//    for var i := 0 to memProduct.RecordCount - 1 do begin
//      FDateTime := UnixToDateTime(StrToInt64Def(memProduct.FieldByName('udt').AsString, 1699708760));
//      FFileName := memProduct.FieldByName('product').AsString + FormatDateTime('yyyymmddhhnnss', FDateTime) + '.jpg';
//
//
//      AddItem(
//        memProduct.RecNo,
//        memProduct.FieldByName('name').AsString,
//        memProduct.FieldByName('desc').AsString,
//        memProduct.FieldByName('price').AsString,
//        FFileName
//      );
//
//      memProduct.Next;
//    end;
//  end);
end;

procedure TFHome.QProductAfterOpen(Sender: TObject);
begin
  var FDateTime : TDateTime;
  var SQLAdd, FFileName : String;

  for var i := 0 to memProduct.RecordCount - 1 do begin
    FDateTime := UnixToDateTime(StrToInt64Def(memProduct.FieldByName('udt').AsString, 1699708760));
    FFileName := memProduct.FieldByName('product').AsString + FormatDateTime('yyyymmddhhnnss', FDateTime) + '.jpg';

    if not FileExists(FFileName) then
      DownloadGambarBase64(memProduct.FieldByName('product').AsString);

    memProduct.Next;
  end;


  TThread.Synchronize(nil, procedure begin

    memProduct.First;

    for var i := 0 to memProduct.RecordCount - 1 do begin
      FDateTime := UnixToDateTime(StrToInt64Def(memProduct.FieldByName('udt').AsString, 1699708760));
      FFileName := memProduct.FieldByName('product').AsString + FormatDateTime('yyyymmddhhnnss', FDateTime) + '.jpg';


      AddItem(
        memProduct.RecNo,
        memProduct.FieldByName('name').AsString,
        memProduct.FieldByName('desc').AsString,
        memProduct.FieldByName('price').AsString,
        FFileName
      );

      memProduct.Next;
    end;
  end);
end;

procedure TFHome.QProductBeforeOpen(Sender: TObject);
begin
//  ShowMessage('2');
end;

procedure TFHome.QProductErroRequest(Sender: TObject);
begin
//  ShowMessage('1');
end;

end.
