program Task1;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

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
    else if (number < min) or (number > max) then
      Writeln('Значение должно попадать в интервал от ', min, ' до ', max)
    else
      break;
  until false;

  Result := number;
end;

function Converting(input: Int32): Int32;
var
  i, temp, output: Int32;
  binary_input, binary_output: array [1 .. 16] of char;
begin
  // Представление введенного числа в бинарном виде
  for i := 16 downto 1 do
  begin
    if input > 0 then
    begin
      temp := input mod 2;
      input := input div 2;
      if temp = 1 then
        binary_input[i] := '1'
      else
        binary_input[i] := '0';
    end
    else
      binary_input[i] := '0';
  end;

  // Перестановка байт
  for i := 1 to 16 do
  begin
    if i <= 8 then
      binary_output[i] := binary_input[i + 8]
    else
      binary_output[i] := binary_input[i - 8];
  end;

  // Обратное преобразование к десятичному виду
  output := 0;
  for i := 16 downto 1 do
    if binary_output[i] = '1' then
      output := output + (1 shl (16 - i));

  Result := output;
end;

var
  input_number: Int32;

begin
  try
    Writeln('Условие задачи №1:');
    Writeln('Дано положительное целочисленное 2-х байтное число.');
    Writeln('Нужно найти значение, которое будет, если поменять байты местами.');
    Writeln;

    // Ввод данных с проверкой
    input_number := InputCheck('Введите число от 0 до 65 535: ', 0, 65535);

    Writeln('Результат преобразования: ', Converting(input_number));

    // Проверка правильности вычислений с помощью повторного преобразования
    // Writeln;
    // Writeln('Тесты:');
    // Writeln('0'#9'->'#9'', Converting(0), ''#9'->'#9'',
    // Converting(Converting(0)));
    // Writeln('1'#9'->'#9'', Converting(1), ''#9'->'#9'',
    // Converting(Converting(1)));
    // Writeln('2'#9'->'#9'', Converting(2), ''#9'->'#9'',
    // Converting(Converting(2)));
    // Writeln('3'#9'->'#9'', Converting(3), ''#9'->'#9'',
    // Converting(Converting(3)));
    // Writeln('4'#9'->'#9'', Converting(4), ''#9'->'#9'',
    // Converting(Converting(4)));
    // Writeln('5'#9'->'#9'', Converting(5), ''#9'->'#9'',
    // Converting(Converting(5)));
    // Writeln('55'#9'->'#9'', Converting(55), ''#9'->'#9'',
    // Converting(Converting(55)));
    // Writeln('555'#9'->'#9'', Converting(555), ''#9'->'#9'',
    // Converting(Converting(555)));
    // Writeln('65530'#9'->'#9'', Converting(65530), ''#9'->'#9'',
    // Converting(Converting(65530)));
    // Writeln('65531'#9'->'#9'', Converting(65531), ''#9'->'#9'',
    // Converting(Converting(65531)));
    // Writeln('65532'#9'->'#9'', Converting(65532), ''#9'->'#9'',
    // Converting(Converting(65532)));
    // Writeln('65533'#9'->'#9'', Converting(65533), ''#9'->'#9'',
    // Converting(Converting(65533)));
    // Writeln('65534'#9'->'#9'', Converting(65534), ''#9'->'#9'',
    // Converting(Converting(65534)));
    // Writeln('65535'#9'->'#9'', Converting(65535), ''#9'->'#9'',
    // Converting(Converting(65535)));

    Readln;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  Readln;

end.
