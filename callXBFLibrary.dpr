program callXBFLibrary;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frmCall_XBF};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'callXBFLibrary';
  Application.CreateForm(TfrmCall_XBF, frmCall_XBF);
  Application.Run;
end.
