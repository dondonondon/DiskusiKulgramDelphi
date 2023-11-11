unit UListBoxCollection;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.ListBox, FMX.Layouts,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Effects, FMX.Edit,
  uK2SQL, uCoreConnection;

type
  TFListBoxConnection = class(TForm)
    lbImgHeader: TListBoxItem;
    Image1: TImage;
    lbHeader: TLabel;
    LbDesc: TLabel;
    lbDetail: TListBoxItem;
    lblHeader: TLabel;
    lblDesc: TLabel;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Button1: TButton;
    mem: TFDMemTable;
    Label3: TLabel;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    lbiHeader: TListBoxHeader;
    lbiSearch: TListBoxHeader;
    Button2: TButton;
    con: TSSQLConnection;
    Q: TK2SQL;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure QAfterOpen(Sender: TObject);
    procedure QErroRequest(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadData(memo : TFDMemTable; lb : TListBox);
  end;

var
  FListBoxConnection: TFListBoxConnection;

implementation

{$R *.fmx}

uses uMenu;

{ TFListBoxConnection }



{ TFListBoxConnection }

procedure TFListBoxConnection.Button1Click(Sender: TObject);
var
  I: Integer;
  item : TListBoxItem;
begin
lbiHeader.Align := TAlignLayout.Top;
FMenu.ListBox1.AddObject(lbiHeader);
lbiSearch.Align := TAlignLayout.Top;
FMenu.ListBox1.AddObject(lbiSearch);
for I := 0 to 10 do begin
lblHeader.Text := 'Item Header '+ IntToStr(i);
item := TListBoxItem(LbDetail.Clone(nil));
FMenu.ListBox1.AddObject(item);
end;
for I := 0 to 10 do begin
lbHeader.Text := 'Item Header '+ IntToStr(i);
item := TListBoxItem(lbImgHeader.Clone(nil));
FMenu.ListBox1.AddObject(item);
end;
FMenu.Show;
end;

procedure TFListBoxConnection.Button2Click(Sender: TObject);
begin
Q.SQL.Text := 'select * from login order by id desc limit 50';
Q.Open(true);
end;

procedure TFListBoxConnection.LoadData(memo: TFDMemTable; lb: TListBox);
var
  I: Integer;
  item : TListBoxItem;
begin
  if (memo.Active) and (memo.Fields[0].AsString<>'no data') then begin
     lb.BeginUpdate;
    while not memo.Eof do begin
      lblHeader.Text := memo.Fields[1].AsString;
      lblDesc.Text := memo.Fields[2].AsString;
      item := TListBoxItem(LbDetail.Clone(nil));
      item.Tag := memo.Fields[0].AsInteger;
      lb.AddObject(item);
      memo.Next;
    end;
    lb.EndUpdate;
  end;
end;

procedure TFListBoxConnection.QAfterOpen(Sender: TObject);
begin

FMenu.ListBox1.Clear;
lbiHeader.Align := TAlignLayout.Top;
FMenu.ListBox1.AddObject(lbiHeader);
lbiSearch.Align := TAlignLayout.Top;
FMenu.ListBox1.AddObject(lbiSearch);
LoadData(mem,FMenu.ListBox1);
FMenu.Show;

end;

procedure TFListBoxConnection.QErroRequest(Sender: TObject);
begin
showmessage(Q.FRespon);
end;

end.
