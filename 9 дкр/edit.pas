unit edit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TfEdit }

  TfEdit = class(TForm)
    Imya: TEdit;
    Save: TBitBtn;
    NotSave: TBitBtn;
    zakaz: TComboBox;
    Pol: TComboBox;
    id: TEdit;
    Surname: TEdit;
    idclienta: TLabel;
    Imyaclienta: TLabel;
    Surnameclienta: TLabel;
    zakazclienta: TLabel;
    Polclienta: TLabel;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fEdit: TfEdit;

implementation

{$R *.lfm}

{ TfEdit }

procedure TfEdit.FormShow(Sender: TObject);
begin
  id.SetFocus;
end;

end.

