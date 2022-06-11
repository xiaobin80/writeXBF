unit UcmosConsole;

interface

Uses
  Windows, Forms, SysUtils;
type 
  TCMOSType = record 
    Seconds : byte; 
    SecondAlarm : byte; 
    Minutes : byte; 
    MinuteAlarm : byte; 
    Hours : byte; 
    HourAlarm : byte; 
    DayOfWeek : byte; 
    DayOfMonth : byte; 
    Month : byte; 
    Year : byte; 
    StatusRegA : byte; 
    StatusRegB : byte; 
    StatusRegC : byte; 
    StatusRegD : byte; 
    DiagStatus : Byte; 
    ShutDownStatus : Byte; 
    FloppyDrive : byte; 
    Reserved1 : byte; 
    FixedDrive : Byte; 
    Reserved2 : byte; 
    Equipment : byte; 
    RAM : word; 
    XMS : word; 
    FixedDriveType1 : byte; 
    FixedDriveType2 : byte; 
    Reserved3 : word; 
    Cylinder1 : word; 
    Head1 : byte; 
    WP1 : word; 
    LZ1 : word; 
    Sector1 : byte; 
    Cylinder2 : word; 
    Head2 : byte; 
    WP2 : word; 
    LZ2 : word; 
    Sector2 : byte; 
    Sys : byte; 
    CheckSum : word; 
    XMS1 : word; 
    DateCentury : byte; 
    InfoFlags : byte; 
    Reserved4: array[1..12] of byte; 
end; 
TByte64 = array[1..64] of byte; 
TCMOS = object 
    CMOSRec : TCMOSType; 
    procedure ReadCMOS; 
    procedure WriteCMOS; 
    procedure DisplayCMOS; 
    //procedure ModifyCMOS; 

end; 


implementation

procedure TCMOS.ReadCMOS; 
begin 
  asm 
    les di,self 
    add di,CMOSRec 
    MOV CX,40H 
    MOV AH,0H 
    MOV BX,0 
    @1: 
    MOV DX,70H 
    MOV AL,AH 
    OUT DX,AL 
    INC DX 
    in AL,dx 
    MOV BYTE PTR es:[di+BX],al 
    INC AH 
    INC BX 
    DEC CX 
    JNZ @1 
  end; 
end;

procedure TCMOS.WriteCMOS; 
begin 
  asm 
    les di,self 
    add di,CMOSRec 
    MOV CX,40H 
    MOV AH,0H 
    MOV BX,0 
    @1: 
    MOV DX,70H 
    MOV AL,AH 
    OUT DX,AL 
    MOV AL,BYTE PTR es:[di+BX] 
    INC DX 
    OUT DX,AL 
    INC AH 
    INC BX 
    DEC CX 
    JNZ @1 
  end; 
end;

procedure TCMOS.DisplayCMOS; 
var 
hd1,hd2,fd1,fd2 : byte; 
begin 
  Writeln(^J^M'CMOS RAM information:'); 
  writeln('Date(MM-DD-YY): ',CMOSRec.Month shr 4,CMOSRec.Month and $f, 
  '-',CMOSRec.DayOfMonth shr 4,CMOSRec.DayOfMonth and $f, 
  '-',CMOSRec.Year shr 4,CMOSRec.Year and $f); 
  writeln('Time(HH:MM:SS): ',CMOSRec.Hours shr 4,CMOSRec.Hours and $f, 
  ':',CMOSRec.Minutes shr 4,CMOSRec.Minutes and $f, 
  ':',CMOSRec.Seconds shr 4,CMOSRec.Seconds and $f); 
  writeln('Conventional Memory: ',CMOSRec.Ram,'KB'); 
  writeln('Extended Memory: ',CMOSRec.XMS,'KB'); 
  hd2 := CMOSRec.FixedDrive and $f; 
  hd1 := CMOSRec.FixedDrive shr 4; 
  if (hd1 <> 0) then 
  begin 
    writeln('Fixed Drive 1: ',CMOSRec.FixedDriveType1); 
    writeln(' Cylinder : ',CMOSRec.Cylinder1); 
    writeln(' Head : ',CMOSRec.Head1); 
    writeln(' Sector: ',CMOSRec.Sector1); 
    writeln(' LZ: ',CMOSRec.LZ1); 
    writeln(' WP: ',CMOSRec.WP1); 
  end; 
  if (hd2 <> 0) then 
  begin 
    writeln('Fixed Drive 2: ',CMOSRec.FixedDriveType2); 
    writeln(' Cylinder : ',CMOSRec.Cylinder2); 
    writeln(' Head : ',CMOSRec.Head2); 
    writeln(' Sector: ',CMOSRec.Sector2); 
    writeln(' LZ: ',CMOSRec.LZ2); 
    writeln(' WP: ',CMOSRec.WP2); 
  end; 
  fd2 := CMOSRec.FloppyDrive and $f; 
  fd1 := CMOSRec.FloppyDrive shr 4; 
  if (fd1 <> 0) then 
  begin 
    write('Floppy Drive 1 : '); 
    case fd1 of 
    1 : writeln('360KB 5.25'''); 
    2 : writeln('1.2MB 5.25'''); 
    4 : writeln('1.44MB 3.5'''); 
    6 : writeln('720KB 3.5'''); 
    end; 
  end ; 
  if (fd2 <> 0) then 
  begin 
    write('Floppy Drive 2 : '); 
    case fd2 of 
    1 : writeln('360KB 5.25'''); 
    2 : writeln('1.2MB 5.25'''); 
    4 : writeln('1.44MB 3.5'''); 
    6 : writeln('720KB 3.5'''); 
    end; 
  end; 
end; 


end.
