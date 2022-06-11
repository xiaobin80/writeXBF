unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils, IniFiles;

type
  TfrmCall_XBF = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnGetDate: TButton;
    btnWriteSQL2k: TButton;
    btnWriteMDB: TButton;
    btnReadSQL2k: TButton;
    btnReadMDB: TButton;
    gboxSerice: TGroupBox;
    btnServiceState: TButton;
    btnStartSerice: TButton;
    btnStopService: TButton;
    edtServiceName: TEdit;
    ComboBox1: TComboBox;
    procedure btnGetDateClick(Sender: TObject);
    procedure btnWriteSQL2kClick(Sender: TObject);
    procedure btnWriteMDBClick(Sender: TObject);
    procedure btnReadSQL2kClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnReadMDBClick(Sender: TObject);
    procedure btnServiceStateClick(Sender: TObject);
    procedure btnStartSericeClick(Sender: TObject);
    procedure btnStopServiceClick(Sender: TObject);
  private
    h1,h2,h3:THandle;
    { Private declarations }
  public
    myini:TIniFile;
    filenames:string;
    { Public declarations }
  end;

type
  Tfun_status=function(ServiceName:pchar):DWORD;stdcall;
  Tfun_start=function(sMachine, sService: String):DWORD;stdcall;
  Tfun_stop=function(sMachine, sService: String):DWORD;stdcall;

var
  frmCall_XBF: TfrmCall_XBF;

  //svc
  svc_status:Tfun_status;
  svc_start:Tfun_start;
  svc_stop:Tfun_stop;
  
implementation

procedure show55(H:THandle);
                  stdcall;external 'XBFGenerate.dll';//access
procedure show5(H:THandle);
                  stdcall;external 'XBFGenerate.dll';//sql
function readXBF(DimRecord: Integer;filename1:WideString):WideString;
                  stdcall;external 'XBFGenerate.dll';
function readXBF_mdb(DimRecord: Integer;filename1:WideString):WideString;
                  stdcall;external 'XBFGenerate.dll';
//function svcStatus(ServiceName:pchar):DWORD;
//                  stdcall;external 'XBFGenerate.dll';
//function svcStart(sMachine, sService: String):DWORD;
//                  stdcall;external 'XBFGenerate.dll';
//function svcStop(sMachine, sService: String):DWORD;
//                  stdcall;external 'XBFGenerate.dll';


{$R *.dfm}

procedure TfrmCall_XBF.btnGetDateClick(Sender: TObject);
var
  year,month,day,DOW:Word;
  //systime1:TSystemTime;
  h1,m1,s1,ms1:word;
begin
  DecodeDateFully(Now,year,month,day,DOW);
  Label1.Caption:=IntToStr(year)+'.';
  Label2.Caption:=IntToStr(month)+'.';
  Label3.Caption:=IntToStr(day);
  //Label4.Caption:=IntToStr(DOW);
  //RightStr(DateTimeToStr(Time),8);
  DecodeTime(Now,h1,m1,s1,ms1);
  Label4.Caption:='时间:'+IntToStr(h1)+':'+ IntToStr(m1)+':'+IntToStr(s1);
end;

procedure TfrmCall_XBF.btnWriteSQL2kClick(Sender: TObject);
begin
  show5(Application.Handle);
end;

procedure TfrmCall_XBF.btnWriteMDBClick(Sender: TObject);
begin
  show55(Application.Handle);
end;

procedure TfrmCall_XBF.btnReadSQL2kClick(Sender: TObject);
begin
  ShowMessage(readXBF(StrToInt(ComboBox1.Text),filenames));
end;

procedure TfrmCall_XBF.FormShow(Sender: TObject);
begin
  myini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'filelist.ini');
  filenames:=ExtractFilePath(ParamStr(0))+myini.ReadString('lists','file1','abc')+'.xbf';
end;

procedure TfrmCall_XBF.btnReadMDBClick(Sender: TObject);
begin
  ShowMessage(readXBF_mdb(StrToInt(ComboBox1.Text),filenames));
end;

procedure TfrmCall_XBF.btnServiceStateClick(Sender: TObject);
var
  StatusVal:integer;
begin
  h1:=0;
  try
    h1:=LoadLibrary('XBFGenerate.dll');
    
    if h1<>0 then
      @svc_status:=GetprocAddress(h1,'svcStatus');
    if (@svc_status<>nil)then
    begin
      StatusVal:=svc_status(pchar(edtServiceName.Text));
    end
    else
    begin
      Application.MessageBox('此版本"XBFGenerate.dll"不支持本功能！','提示',MB_OK);
      Exit;
    end;      
  finally
    FreeLibrary(h1);
  end;

  case StatusVal of
    1:
      begin
        btnStopService.Enabled:=False;
        btnStartSerice.Enabled:=True;
        ShowMessage('The service is not running');
      end;
    2:
      begin
        btnStartSerice.Enabled:=False;
        btnStopService.Enabled:=True;
        ShowMessage('The service is starting');
      end;
    3:
      begin
        btnStopService.Enabled:=False;
        btnStartSerice.Enabled:=True;
        ShowMessage('The service is stopping');
      end;
    4:
      begin
        btnStartSerice.Enabled:=False;
        btnStopService.Enabled:=True;
        ShowMessage('The service is running');
      end;
    5:
      begin
        ShowMessage('The service continue is pending');
      end;
    6:
      begin
        ShowMessage('The service pause is pending');
      end;
    7:
      begin
        ShowMessage('The service is paused');
      end;
    1243452:
      begin
        ShowMessage('No Service');
      end;
  end;
end;

procedure TfrmCall_XBF.btnStartSericeClick(Sender: TObject);
begin
  btnStartSerice.Enabled:=False;

  h2:=0;
  try
    h2:=LoadLibrary('XBFGenerate.dll');

    if h2<>0 then
      @svc_start:=GetprocAddress(h2,'svcStart');
    if (@svc_start<>nil)then
    begin
      svc_start('',edtServiceName.Text);
    end
    else
    begin
      Application.MessageBox('此版本"XBFGenerate.dll"不支持本功能！','提示',MB_OK);
      Exit;
    end;
  finally
    FreeLibrary(h2);
  end;

end;

procedure TfrmCall_XBF.btnStopServiceClick(Sender: TObject);
begin
  btnStopService.Enabled:=False;

  h3:=0;
  try
    h3:=LoadLibrary('XBFGenerate.dll');

    if h3<>0 then
      @svc_stop:=GetprocAddress(h3,'svcStop');
    if (@svc_stop<>nil)then
    begin
      svc_stop('',edtServiceName.Text);
    end
    else
    begin
      Application.MessageBox('此版本"XBFGenerate.dll"不支持本功能！','提示',MB_OK);
      Exit;
    end;
  finally
    FreeLibrary(h3);
  end;

end;

end.
