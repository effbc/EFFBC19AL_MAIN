xmlport 50178 test
{
    Direction = Import;
    Format = VariableText;
    Permissions =;

    schema
    {
        textelement(Employees)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                textelement(no)
                {
                    XmlName = 'No';
                }
                textelement(option)
                {
                    XmlName = 'Option';
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort();
    begin
        Message('Testing on Init XML Port');
    end;

    trigger OnPostXmlPort();
    begin
        Message('Testing on Post XML Port');
    end;

    trigger OnPreXmlPort();
    begin
        Message('Testing on Pre XML Port');
    end;
}

