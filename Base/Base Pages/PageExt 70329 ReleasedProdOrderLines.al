pageextension 70329 ReleasedProdOrdeLinesEt extends "Released Prod. Order Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter("Production BOM No.")
        {
            field("Soldering Time(in Min)"; "Soldering Time(in Min)")
            {
                ApplicationArea = All;
            }
            field("Total Benchmarks(in Min)"; "Total Benchmarks(in Min)")
            {
                ApplicationArea = All;
            }
            field("Benchmark(in Min)"; "Benchmark(in Min)")
            {
                ApplicationArea = All;
            }
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                Rec."Total Benchmarks(in Min)" := Rec."Benchmark(in Min)" * Quantity;
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF NOT (USERID IN ['EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\VISHNUPRIYA']) THEN
            ERROR('Dont have rights to Insert');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF NOT (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\VSNGEETHA', 'EFFTRONICS\GRAVI', 'EFFTRONICS\RENUKACH']) THEN
            ERROR('Dont have rights to Modify');
    end;

    var
        myInt: Integer;
}