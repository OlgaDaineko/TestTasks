program Task2;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils, Math;

// Проверка ввода целого положительного числа в определенном интервале
function InputCheck(input: String; min, max: Int32): Int32;
var
  number: Int32;
begin
  repeat
    Write(input);

{$I-}
    Read(number);
{$I+}
    if IoResult <> 0 then
      Writeln('Введите целое положительное число')
    else if (number < min) and (max = -1) then
      Writeln('Введите число больше ', min)
    else if (number < min) or (max > 0) and (number > max) then
      Writeln('Значение должно попадать в интервал от ', min, ' до ', max)
    else
      break;
  until false;

  Result := number;
end;

function Sum(N, w: Int32): Int32;
var
  i, Sum: Int32;
begin
  // Подсчет максимального веса отобранных монет
  Sum := 0;
  for i := 1 to N - 1 do
    Sum := Sum + i * w;
  Result := Sum;
end;

function Count(Sum, P, d, N: Int32): Double;
begin
  // Если вес отобранных монет максимален, значит фальшивые находятся в последней корзине
  // иначе номер корзины определяется через количество фальшивых монет
  if P = Sum then
    Result := N
  else
    Result := (Sum - P) / d;
end;

// Функция для тестирования программы, возвращает значение числа P
// Здесь number - номер корзины с фальшивыми монетами
function ForTest(N, w, d, number: Int32): Int32;
var
  i, temp: Int32;
begin
  temp := 0;
  for i := 1 to N - 1 do
    if i = number then
      temp := temp + i * (w - d)
    else
      temp := temp + i * w;
  Result := temp;
end;

var
  N, w, d, P: Int32;

begin
  try
    Writeln('Условие задачи №2:');
    Writeln('В N корзинах находятся золотые монеты. Корзины пронумерованы числами от 1 до N.');
    Writeln('Во всех корзинах, кроме одной, монеты весят по w граммов. В одной корзине монеты фальшивые и весят w – d граммов.');
    Writeln('Волшебник берет 1 монету из первой корзины, 2 монеты из второй корзины, и так далее, и, наконец, N - 1 монету из (N - 1)-й корзины.');
    Writeln('Из N-й корзины он не берет ничего. Он взвешивает взятые монеты и сразу указывает на корзину с фальшивыми монетами.');
    Writeln('Напишите программу, которая сможет выполнять такое волшебство.');
    Writeln('Дано: четыре целых числа: N, w, d и P – суммарный вес отобранных монет.');
    Writeln('Найти номер корзины с фальшивыми монетами.');
    Writeln;

    // Ввод данных с проверкой
    N := InputCheck('Введите число корзин N (не меньше 2): ', 2, -1);
    w := InputCheck
      ('Введите вес одной настоящей монеты w (не меньше 2): ', 2, -1);
    d := InputCheck
      ('Введите разницу в весе между настоящей монетой и фальшивой d (меньше веса настоящей): ',
      1, w - 1);

    repeat
      P := InputCheck
        ('Введите суммарный вес отобранных монет P (не меньше веса фальшивой): ',
        w - d, Sum(N, w));
      if (Ceil(Count(Sum(N, w), P, d, N)) <> Floor(Count(Sum(N, w), P, d, N)))
        or ((Count(Sum(N, w), P, d, N)) > N) then
        Writeln('Некорректное значение числа P')
      else
        break;
    until false;

    Writeln('Фальшивые монеты находятся в корзине номер ',
      Trunc(Count(Sum(N, w), P, d, N)));

    // Проверка правильности вычислений
    // Writeln;
    // Writeln('Тесты:');
    // Writeln;
    // Writeln('N = 2,'#9#9'w = 2,'#9#9'd = 1,'#9#9'P = ', ForTest(2, 2, 1, 1),
    // ''#9#9'->'#9'', Trunc(Count(Sum(2, 2), ForTest(2, 2, 1, 1), 1, 2)
    // ), ' = 1');
    // Writeln('N = 2,'#9#9'w = 2,'#9#9'd = 1,'#9#9'P = ', ForTest(2, 2, 1, 2),
    // ''#9#9'->'#9'', Trunc(Count(Sum(2, 2), ForTest(2, 2, 1, 2), 1, 2)
    // ), ' = 2');
    // Writeln;
    // Writeln('N = 3,'#9#9'w = 5,'#9#9'd = 1,'#9#9'P = ', ForTest(3, 5, 1, 1),
    // ''#9#9'->'#9'', Trunc(Count(Sum(3, 5), ForTest(3, 5, 1, 1), 1, 3)
    // ), ' = 1');
    // Writeln('N = 3,'#9#9'w = 5,'#9#9'd = 1,'#9#9'P = ', ForTest(3, 5, 1, 2),
    // ''#9#9'->'#9'', Trunc(Count(Sum(3, 5), ForTest(3, 5, 1, 2), 1, 3)
    // ), ' = 2');
    // Writeln('N = 3,'#9#9'w = 5,'#9#9'd = 1,'#9#9'P = ', ForTest(3, 5, 1, 3),
    // ''#9#9'->'#9'', Trunc(Count(Sum(3, 5), ForTest(3, 5, 1, 3), 1, 3)
    // ), ' = 3');
    // Writeln;
    // Writeln('N = 5,'#9#9'w = 10,'#9#9'd = 3,'#9#9'P = ', ForTest(5, 10, 3, 1),
    // ''#9#9'->'#9'', Trunc(Count(Sum(5, 10), ForTest(5, 10, 3, 1), 3, 5)
    // ), ' = 1');
    // Writeln('N = 5,'#9#9'w = 10,'#9#9'd = 3,'#9#9'P = ', ForTest(5, 10, 3, 2),
    // ''#9#9'->'#9'', Trunc(Count(Sum(5, 10), ForTest(5, 10, 3, 2), 3, 5)
    // ), ' = 2');
    // Writeln('N = 5,'#9#9'w = 10,'#9#9'd = 3,'#9#9'P = ', ForTest(5, 10, 3, 3),
    // ''#9#9'->'#9'', Trunc(Count(Sum(5, 10), ForTest(5, 10, 3, 3), 3, 5)
    // ), ' = 3');
    // Writeln('N = 5,'#9#9'w = 10,'#9#9'd = 3,'#9#9'P = ', ForTest(5, 10, 3, 4),
    // ''#9#9'->'#9'', Trunc(Count(Sum(5, 10), ForTest(5, 10, 3, 4), 3, 5)
    // ), ' = 4');
    // Writeln('N = 5,'#9#9'w = 10,'#9#9'd = 3,'#9#9'P = ', ForTest(5, 10, 3, 5),
    // ''#9#9'->'#9'', Trunc(Count(Sum(5, 10), ForTest(5, 10, 3, 5), 3, 5)
    // ), ' = 5');
    // Writeln;
    // Writeln('N = 10,'#9#9'w = 30,'#9#9'd = 10,'#9#9'P = ',
    // ForTest(10, 30, 10, 1), ''#9'->'#9'',
    // Trunc(Count(Sum(10, 30), ForTest(10, 30, 10, 1), 10, 10)), ' = 1');
    // Writeln('N = 10,'#9#9'w = 30,'#9#9'd = 10,'#9#9'P = ',
    // ForTest(10, 30, 10, 2), ''#9'->'#9'',
    // Trunc(Count(Sum(10, 30), ForTest(10, 30, 10, 2), 10, 10)), ' = 2');
    // Writeln('N = 10,'#9#9'w = 30,'#9#9'd = 10,'#9#9'P = ',
    // ForTest(10, 30, 10, 3), ''#9'->'#9'',
    // Trunc(Count(Sum(10, 30), ForTest(10, 30, 10, 3), 10, 10)), ' = 3');
    // Writeln('N = 10,'#9#9'w = 30,'#9#9'd = 10,'#9#9'P = ',
    // ForTest(10, 30, 10, 4), ''#9'->'#9'',
    // Trunc(Count(Sum(10, 30), ForTest(10, 30, 10, 4), 10, 10)), ' = 4');
    // Writeln('N = 10,'#9#9'w = 30,'#9#9'd = 10,'#9#9'P = ',
    // ForTest(10, 30, 10, 5), ''#9'->'#9'',
    // Trunc(Count(Sum(10, 30), ForTest(10, 30, 10, 5), 10, 10)), ' = 5');
    // Writeln('N = 10,'#9#9'w = 30,'#9#9'd = 10,'#9#9'P = ',
    // ForTest(10, 30, 10, 6), ''#9'->'#9'',
    // Trunc(Count(Sum(10, 30), ForTest(10, 30, 10, 6), 10, 10)), ' = 6');
    // Writeln('N = 10,'#9#9'w = 30,'#9#9'd = 10,'#9#9'P = ',
    // ForTest(10, 30, 10, 7), ''#9'->'#9'',
    // Trunc(Count(Sum(10, 30), ForTest(10, 30, 10, 7), 10, 10)), ' = 7');
    // Writeln('N = 10,'#9#9'w = 30,'#9#9'd = 10,'#9#9'P = ',
    // ForTest(10, 30, 10, 8), ''#9'->'#9'',
    // Trunc(Count(Sum(10, 30), ForTest(10, 30, 10, 8), 10, 10)), ' = 8');
    // Writeln('N = 10,'#9#9'w = 30,'#9#9'd = 10,'#9#9'P = ',
    // ForTest(10, 30, 10, 9), ''#9'->'#9'',
    // Trunc(Count(Sum(10, 30), ForTest(10, 30, 10, 9), 10, 10)), ' = 9');
    // Writeln('N = 10,'#9#9'w = 30,'#9#9'd = 10,'#9#9'P = ',
    // ForTest(10, 30, 10, 10), ''#9'->'#9'',
    // Trunc(Count(Sum(10, 30), ForTest(10, 30, 10, 10), 10, 10)), ' = 10');
    // Writeln;
    // Writeln('N = 100,'#9'w = 50,'#9#9'd = 5,'#9#9'P = ', ForTest(100, 50, 5, 1),
    // ''#9'->'#9'', Trunc(Count(Sum(100, 50), ForTest(100, 50, 5, 1), 5, 100)
    // ), ' = 1');
    // Writeln('N = 100,'#9'w = 50,'#9#9'd = 5,'#9#9'P = ',
    // ForTest(100, 50, 5, 10), ''#9'->'#9'',
    // Trunc(Count(Sum(100, 50), ForTest(100, 50, 5, 10), 5, 100)), ' = 10');
    // Writeln('N = 100,'#9'w = 50,'#9#9'd = 5,'#9#9'P = ',
    // ForTest(100, 50, 5, 20), ''#9'->'#9'',
    // Trunc(Count(Sum(100, 50), ForTest(100, 50, 5, 20), 5, 100)), ' = 20');
    // Writeln('N = 100,'#9'w = 50,'#9#9'd = 5,'#9#9'P = ',
    // ForTest(100, 50, 5, 30), ''#9'->'#9'',
    // Trunc(Count(Sum(100, 50), ForTest(100, 50, 5, 30), 5, 100)), ' = 30');
    // Writeln('N = 100,'#9'w = 50,'#9#9'd = 5,'#9#9'P = ',
    // ForTest(100, 50, 5, 40), ''#9'->'#9'',
    // Trunc(Count(Sum(100, 50), ForTest(100, 50, 5, 40), 5, 100)), ' = 40');
    // Writeln('N = 100,'#9'w = 50,'#9#9'd = 5,'#9#9'P = ',
    // ForTest(100, 50, 5, 50), ''#9'->'#9'',
    // Trunc(Count(Sum(100, 50), ForTest(100, 50, 5, 50), 5, 100)), ' = 50');
    // Writeln('N = 100,'#9'w = 50,'#9#9'd = 5,'#9#9'P = ',
    // ForTest(100, 50, 5, 60), ''#9'->'#9'',
    // Trunc(Count(Sum(100, 50), ForTest(100, 50, 5, 60), 5, 100)), ' = 60');
    // Writeln('N = 100,'#9'w = 50,'#9#9'd = 5,'#9#9'P = ',
    // ForTest(100, 50, 5, 70), ''#9'->'#9'',
    // Trunc(Count(Sum(100, 50), ForTest(100, 50, 5, 70), 5, 100)), ' = 70');
    // Writeln('N = 100,'#9'w = 50,'#9#9'd = 5,'#9#9'P = ',
    // ForTest(100, 50, 5, 80), ''#9'->'#9'',
    // Trunc(Count(Sum(100, 50), ForTest(100, 50, 5, 80), 5, 100)), ' = 80');
    // Writeln('N = 100,'#9'w = 50,'#9#9'd = 5,'#9#9'P = ',
    // ForTest(100, 50, 5, 90), ''#9'->'#9'',
    // Trunc(Count(Sum(100, 50), ForTest(100, 50, 5, 90), 5, 100)), ' = 90');
    // Writeln('N = 100,'#9'w = 50,'#9#9'd = 5,'#9#9'P = ',
    // ForTest(100, 50, 5, 100), ''#9'->'#9'',
    // Trunc(Count(Sum(100, 50), ForTest(100, 50, 5, 100), 5, 100)), ' = 100');

    Readln;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  Readln;

end.
