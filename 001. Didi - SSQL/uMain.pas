unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uK2SQL, System.Rtti, FMX.Grid.Style, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, FMX.ScrollBox,
  FMX.Grid;

type
  TFMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Q1: TK2SQL;
    mem1: TFDMemTable;
    StringGrid1: TStringGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Q1BeforeOpen(Sender: TObject);
    procedure Q1AfterOpen(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.fmx}

uses uMenu, UListBoxCollection;

procedure TFMain.Button1Click(Sender: TObject);
begin
UListBoxCollection.FListBoxConnection.Show;
end;

procedure TFMain.Button2Click(Sender: TObject);
begin
Q1.SQL.Text := 'select * from login order by id desc limit 50';
Q1.Open();
end;

procedure TFMain.Button3Click(Sender: TObject);
begin
Q1.SQL.Text := 'select * from login order by id desc limit 50';
Q1.Open(true);
end;

procedure TFMain.Q1AfterOpen(Sender: TObject);
begin
mem1.EnableControls;
end;

procedure TFMain.Q1BeforeOpen(Sender: TObject);
begin
mem1.DisableControls;
end;

end.
