unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, Spin;

type

  { TForm1 }

  TForm1 = class(TForm)
    Exitt: TBitBtn;
    Calculate: TButton;
    Clear: TButton;
    Decision: TButton;
    Input_summ: TEdit;
    Output_simple: TEdit;
    Output_hard: TEdit;
    Label1: TLabel;
    Start_summ: TLabel;
    Percent: TLabel;
    Year: TLabel;
    Simple: TLabel;
    Hard: TLabel;
    Output_decision: TMemo;
    Input_percent: TSpinEdit;
    Input_year: TSpinEdit;
    procedure ExittClick(Sender: TObject);
    procedure CalculateClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure DecisionClick(Sender: TObject);
    procedure KittyClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  S, result1, result2: Real;
  P, n: Integer;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.ClearClick(Sender: TObject);
begin
  Input_summ.Clear;
  Output_simple.Clear;
  Output_hard.Clear;
  Input_percent.Clear;
  Input_year.Clear;
  Output_decision.Clear;
end;

procedure TForm1.DecisionClick(Sender: TObject);
begin

  if Input_summ.Text = '' then
     begin
       ShowMessage('Некорректный ввод. Повторите попытку.');
       Exit;
     end;

  S := StrToFloat(Input_summ.Text);
  P := Input_percent.Value;
  n := Input_year.Value;


  Output_decision.Lines.add('При расчёте простых процентов используется данная формула: ');
  Output_decision.Lines.add('S * (1 + n * (P/100)), где S - начальная сумма, P - процентная ставка, n - количество лет');
  Output_decision.Lines.add(FloatToStr(S) + ' * (1 + ' + IntToStr(n) + ' * (' + IntToStr(P) + '/100)) = ' + FloatToStr(result1));

  Output_decision.Lines.add('При расчёте сложных процентов используется данная формула: ');
  Output_decision.Lines.add('S * (1 + P/100)^n, где S - начальная сумма, P - процентная ставка, n - количество лет');
  Output_decision.Lines.add(FloatToStr(S) + ' * (1 + ' + IntToStr(P) + '/100)) ^ '+ IntToStr(n) + ' = ' + FloatToStr(result2));
end;


procedure TForm1.CalculateClick(Sender: TObject);
begin
  if Input_summ.Text <> '' then
     begin
       S := StrToFloat(Input_summ.Text);
       P := Input_percent.Value;
       n := Input_year.Value;

       result1 := S *(1 + n * (P/100));
       Output_simple.Text := FloatToStr(result1);

       result2 := S * exp(n*ln((1 + 0.01 * P)));
       Output_hard.Text := FloatToStrF(result2, ffFixed, 0, 2);
     end;
  if Input_summ.Text = '' then
     begin
       ShowMessage('Некорректный ввод. Повторите попытку.');
       Exit;
     end;
end;

procedure TForm1.ExittClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.KittyClick(Sender: TObject);
begin
  ShowMessage('Теперь у вас лапки)');
end;

end.

