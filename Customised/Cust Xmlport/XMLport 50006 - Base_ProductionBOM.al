xmlport 50006 Base_ProductionBOM
{
    Format = VariableText;

    schema
    {
        textelement(ProdBOM)
        {
            tableelement("<prodbomheader>"; "Production BOM Header")
            {
                XmlName = 'ProdBOMHeader';
                fieldelement(No; "<ProdBOMHeader>"."No.")
                {
                }
                fieldelement(Description; "<ProdBOMHeader>".Description)
                {
                }
                fieldelement(SearchName; "<ProdBOMHeader>"."Search Name")
                {
                }
                fieldelement(UnitofMeasureCode; "<ProdBOMHeader>"."Unit of Measure Code")
                {
                }
                fieldelement(Status; "<ProdBOMHeader>".Status)
                {
                }

                trigger OnAfterGetRecord();
                var
                    NewVisit: Record 6710;
                begin

                    /*
                     "<ProdBOMHeader>".SETRECFILTER;
                     IF "<ProdBOMHeader>".GET("<ProdBOMHeader>"."No.") THEN BEGIN
                         NewVisit."User ID" := USERID;
                         NewVisit.Description := Caption + ' ' + "No.";
                         NewVisit.Link := 'ProductionBOM&BOM=' + "No." + '&View=Overview';
                         NewVisit.TableID := DATABASE::"Production BOM Header";
                         NewVisit.INSERT(TRUE);
                     END;
                     */  //Nav 2016 version not compiled beacuse of code commented
                end;
            }
            tableelement("<prodbomline>"; "Production BOM Line")
            {
                XmlName = 'ProdBOMLine';
                fieldelement(ProductionBOMNo; "<ProdBOMLine>"."Production BOM No.")
                {
                }
                fieldelement(LineNo; "<ProdBOMLine>"."Line No.")
                {
                }
                fieldelement(Type; "<ProdBOMLine>".Type)
                {
                }
                fieldelement(No; "<ProdBOMLine>"."No.")
                {
                }
                fieldelement(Description; "<ProdBOMLine>".Description)
                {
                }
                fieldelement(Position; "<ProdBOMLine>".Position)
                {
                }
                fieldelement(Position2; "<ProdBOMLine>"."Position 2")
                {
                }
                fieldelement(Position3; "<ProdBOMLine>"."Position 3")
                {
                }
                fieldelement(RoutingLinkCode; "<ProdBOMLine>"."Routing Link Code")
                {
                }
                fieldelement(Quantityper; "<ProdBOMLine>"."Quantity per")
                {
                }

                trigger OnPreXmlItem();
                begin
                    "<ProdBOMLine>".SETFILTER("Production BOM No.", "<ProdBOMHeader>".GETFILTER("No."));
                end;
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

    var
        LineInserted: Boolean;
        DateImported: Boolean;
        CreateThisTitle: Label 'Create New Production BOM';
        SearchThis: Label 'Search Production BOMs';
        Caption: Label 'Production BOM';
        BrowseThis: Label 'Browse BOM';
        Overview: Label 'Overview';
        ProdBOMVersions: Label 'Versions';
        ProdBOMComments: Label 'Comments';
        RelatedInfo: Label 'See Also';
        CommonTasks: Label 'Common Tasks';
        CreateLine: Label 'Create New Line';
        CreateComment: Label 'Create New Comment';
        CreateVersion: Label 'Create New Version';
        EditThis: Label 'Edit BOM';
        DeleteThis: Label 'Delete BOM';
        CreateThis: Label 'Create New BOM';
        DeleteThisPrompt: Label 'Delete BOM?';
        DeleteLinePrompt: Label 'Delete Line?';
        DeleteCommentPrompt: Label 'Delete Comment?';
        DeleteVersionPrompt: Label 'Delete Version?';
        NoLines: Label 'There are no lines for this BOM';
        NoComments: Label 'There are no comments for this BOM';
        NoVersions: Label 'There are no versions for this BOM';
}

