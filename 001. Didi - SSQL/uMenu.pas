unit uMenu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.StdCtrls, FMX.Controls.Presentation, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uK2SQL;

type
  TFMenu = class(TForm)
    lyMain: TLayout;
    ListBox1: TListBox;
    QHapus: TK2SQL;
    FDMemTable1: TFDMemTable;
    procedure FormShow(Sender: TObject);
    procedure ListBox1ItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure QHapusAfterOpen(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMenu: TFMenu;

implementation

{$R *.fmx}

uses UListBoxCollection;

procedure TFMenu.FormShow(Sender: TObject);
begin
ListBox1.AniCalculations.BoundsAnimation := True;
end;

procedure TFMenu.ListBox1ItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
QHapus.SQL.Text := format('delete from login where id="%s"',[IntToStr(Item.Tag)]);
QHapus.Open(true);

end;

procedure TFMenu.QHapusAfterOpen(Sender: TObject);
begin
showmessage('Data terhapus');
end;

end.
