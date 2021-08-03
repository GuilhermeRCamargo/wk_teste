unit mDefObj;

interface

type
  TIniField = class(TCustomAttribute)
  private
    fKey: string;
  public
    constructor Create(AKey: string);
  published
    property Key: string read fKey write fKey;
  end;

  TDefObj = class
  public

  end;

implementation

end.
