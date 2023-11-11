program ListBoxItem;

uses
  System.StartUpCopy,
  FMX.Forms,
  UListBoxCollection in 'UListBoxCollection.pas' {FListBoxConnection},
  uMenu in 'uMenu.pas' {FMenu},
  uMain in 'uMain.pas' {FMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TFMenu, FMenu);
  Application.CreateForm(TFListBoxConnection, FListBoxConnection);
  Application.Run;
end.
