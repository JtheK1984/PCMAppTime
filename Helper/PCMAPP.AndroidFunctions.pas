unit PCMAPP.AndroidFunctions;

interface

function GetCodename(VerString: string): string;

implementation

function GetCodename(VerString: string): string;
begin
  try
    if VerString = '1.0' then
      Result := 'BASE'
    else if VerString = '1.1' then
      Result := 'BASE_1_1'
    else if VerString = '1.5' then
      Result := 'CUPCAKE'
    else if VerString = '1.6' then
      Result := 'DONUT'
    else if VerString = '2.0' then
      Result := 'ECLAIR'
    else if VerString = '2.0.1' then
      Result := 'ECLAIR_0_1'
    else if VerString = '2.1' then
      Result := 'ECLAIR_MR1'
    else if VerString = '2.2' then
      Result := 'FROYO'
    else if VerString = '2.3' then
      Result := 'GINGERBREAD'
    else if VerString = '2.3.3' then
      Result := 'GINGERBREAD_MR1'
    else if VerString = '3.0' then
      Result := 'HONEYCOMB'
    else if VerString = '3.1' then
      Result := 'HONEYCOMB_MR1'
    else if VerString = '3.2' then
      Result := 'HONEYCOMB_MR2'
    else if VerString = '4.0' then
      Result := 'ICE_CREAM_SANDWICH'
    else if VerString = '4.0.3' then
      Result := 'ICE_CREAM_SANDWICH_MR1'
    else if VerString = '4.1' then
      Result := 'JELLY_BEAN'
    else if VerString = '4.2' then
      Result := 'JELLY_BEAN_MR1'
    else if VerString = '4.3' then
      Result := 'JELLY_BEAN_MR2'
    else if Pos('4.4',VerString) = 1 then
      Result := 'KITKAT'
    else if VerString = '10' then
      Result := 'Android '
    else if VerString = '11' then
      Result := 'Android '
    else Result := 'Android ';
  except
  end;
end;

end.
