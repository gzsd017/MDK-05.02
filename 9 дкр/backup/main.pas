unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  Grids, edit;

type

  { TfMain }

  TfMain = class(TForm)
    Panel1: TPanel;
    bAdd: TSpeedButton;
    bEdit: TSpeedButton;
    bDel: TSpeedButton;
    bSort: TSpeedButton;
    SG: TStringGrid;
    procedure bAddClick(Sender: TObject);
    procedure bDelClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bSortClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

type
  Market = record
    Name: string[100];
    Price: string[20];
    Warehouse: string[10];
    Maker: string[100];
    Category: string[100];
  end; //record

var
  fMain: TfMain;
  adres: string; //адрес, откуда запущена программа

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.bAddClick(Sender: TObject);
begin
  //очищаем поля, если там что-то есть:
  fEdit.eName.Text:= '';
  fEdit.ePrice.Text:= '';
  fEdit.eCategory.Text:= '';
  fEdit.eMaker.Text:= '';
  //устанавливаем ModalResult редактора в mrNone:
  fEdit.ModalResult:= mrNone;
  //теперь выводим форму:
  fEdit.ShowModal;
  //если пользователь ничего не ввел - выходим:
  if (fEdit.eName.Text = '') or (fEdit.ePrice.Text = '') or (fEdit.eCategory.Text = '') or (fEdit.eMaker.Text = '') then exit;
  //если пользователь не нажал "Сохранить" - выходим:
  if fEdit.ModalResult <> mrOk then exit;
  //иначе добавляем в сетку строку, и заполняем её:
  SG.RowCount:= SG.RowCount + 1;
  SG.Cells[0, SG.RowCount-1]:= fEdit.eName.Text;
  SG.Cells[1, SG.RowCount-1]:= fEdit.ePrice.Text;
  SG.Cells[2, SG.RowCount-1]:= fEdit.eMaker.Text;
  SG.Cells[3, SG.RowCount-1]:= fEdit.CBNote.Text;
  SG.Cells[4, SG.RowCount-1]:= fEdit.eCategory.Text;
end;

procedure TfMain.bDelClick(Sender: TObject);
begin
  //если данных нет - выходим:
  if SG.RowCount = 1 then exit;
  //иначе выводим запрос на подтверждение:
  if MessageDlg('Требуется подтверждение',
                'Вы действительно хотите удалить товар "' +
                SG.Cells[0, SG.Row] + '"?',
      mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then
         SG.DeleteRow(SG.Row);
end;

procedure TfMain.bEditClick(Sender: TObject);
begin
  //если данных в сетке нет - просто выходим:
  if SG.RowCount = 1 then exit;
  //иначе записываем данные в форму редактора:
  fEdit.eName.Text:= SG.Cells[0, SG.Row];
  fEdit.ePrice.Text:= SG.Cells[1, SG.Row];
  fEdit.eMaker.Text:= SG.Cells[2, SG.Row];
  fEdit.CBNote.Text:= SG.Cells[3, SG.Row];
  fEdit.eCategory.Text:= SG.Cells[4, SG.Row];
  //устанавливаем ModalResult редактора в mrNone:
  fEdit.ModalResult:= mrNone;
  //теперь выводим форму:
  fEdit.ShowModal;
  //сохраняем в сетку возможные изменения,
  //если пользователь нажал "Сохранить":
  if fEdit.ModalResult = mrOk then begin
    SG.Cells[0, SG.Row]:= fEdit.eName.Text;
    SG.Cells[1, SG.Row]:= fEdit.ePrice.Text;
    SG.Cells[2, SG.Row]:= fEdit.eMaker.Text;
    SG.Cells[3, SG.Row]:= fEdit.CBNote.Text;
    SG.Cells[4, SG.Row]:= fEdit.eCategory.Text
  end;
end;

procedure TfMain.bSortClick(Sender: TObject);
begin
  //если данных в сетке нет - просто выходим:
  if SG.RowCount = 1 then exit;
  //иначе сортируем список:
  SG.SortColRow(true, 0);
end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  MyMarket: Market; //для очередной записи
  f: file of Market; //файл данных
  i: integer; //счетчик цикла
begin
  //если строки данных пусты, просто выходим:
  if SG.RowCount = 1 then exit;
  //иначе открываем файл для записи:
  try
    AssignFile(f, adres + 'telephones.dat');
    Rewrite(f);
    //теперь цикл - от первой до последней записи сетки:
    for i:= 1 to SG.RowCount-1 do begin
      //получаем данные текущей записи:
      MyMarket.Name:= SG.Cells[0, i];
      MyMarket.Price:= SG.Cells[1, i];
      MyMarket.Warehouse:= SG.Cells[2, i];
      MyMarket.Maker:= SG.Cells[3, i];
      MyMarket.Category:= SG.Cells[4, i];
      //записываем их:
      Write(f, MyMarket);
    end;
  finally
    CloseFile(f);
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  MyMarket: Market; //для очередной записи
  f: file of Market; //файл данных
  i: integer; //счетчик цикла
begin
  //сначала получим адрес программы:
  adres:= ExtractFilePath(ParamStr(0));
  //настроим сетку:
  SG.Cells[0, 0]:= 'ID клента';
  SG.Cells[1, 0]:= 'Фамилия клиента';
  SG.Cells[2, 0]:= 'Имя клиента';
  SG.Cells[3, 0]:= 'Наличие заказов';
  SG.Cells[4, 0]:= 'Пол клиента';
  SG.ColWidths[0]:= 100;
  SG.ColWidths[1]:= 200;
  SG.ColWidths[2]:= 200;
  SG.ColWidths[3]:= 150;
  SG.ColWidths[4]:= 100;

  //если файла данных нет, просто выходим:
  if not FileExists(adres + 'market.dat') then exit;
  //иначе файл есть, открываем его для чтения и
  //считываем данные в сетку:
  try
    AssignFile(f, adres + 'market.dat');
    Reset(f);
    //теперь цикл - от первой до последней записи сетки:
    while not Eof(f) do begin
      //считываем новую запись:
      Read(f, MyMarket);
      //добавляем в сетку новую строку, и заполняем её:
        SG.RowCount:= SG.RowCount + 1;
        SG.Cells[0, SG.RowCount-1]:= MyMarket.Name;
        SG.Cells[1, SG.RowCount-1]:= MyMarket.Price;
        SG.Cells[2, SG.RowCount-1]:= MyMarket.Warehouse;
        SG.Cells[3, SG.RowCount-1]:= MyMarket.Maker;
        SG.Cells[4, SG.RowCount-1]:= MyMarket.Category;
    end;
  finally
    CloseFile(f);
  end;
end;

end.

