table 60094 "SO Prod.Order Details"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Sales Order No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Sales Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; Type; Option)
        {
            OptionMembers = " ","Prod. Order",Job;
            DataClassification = CustomerContent;
        }
        field(5; "No."; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                if Type = Type::"Prod. Order" then begin
                    ProductionOrder.SetRange("Sales Order No.", "Sales Order No.");
                    ProductionOrder.SetRange("Sales Order Line No.", "Sales Order Line No.");
                    ProductionOrder.SetRange("Schedule Line No.", "Line No.");
                    if ProductionOrder.Find('-') then begin
                        if PAGE.RunModal(0, ProductionOrder) = ACTION::LookupOK then begin
                            "No." := ProductionOrder."No.";
                            Validate("No.");
                        end;
                    end else begin
                        ProductionOrder1.SetFilter("Sales Order No.", '=%1', '');
                        if PAGE.RunModal(0, ProductionOrder1) = ACTION::LookupOK then begin
                            "No." := ProductionOrder1."No.";
                            Validate("No.");
                        end;
                        ProductionOrder1."Sales Order No." := "Sales Order No.";
                        ProductionOrder1."Sales Order Line No." := "Sales Order Line No.";
                        ProductionOrder1."Schedule Line No." := "Line No.";
                        ProductionOrder1.Modify;
                    end;
                end else
                    if Type = Type::Job then begin
                        JobOrder.SetRange("Sales Order No.", "Sales Order No.");
                        JobOrder.SetRange("Sales Order Line No.", "Sales Order Line No.");
                        if JobOrder.Find('-') then begin
                            if PAGE.RunModal(0, JobOrder) = ACTION::LookupOK then begin
                                "No." := JobOrder."No.";
                                Validate("No.");
                            end;
                        end else begin
                            JobOrder1.SetFilter("Sales Order No.", '=%1', '');
                            if PAGE.RunModal(0, JobOrder1) = ACTION::LookupOK then begin
                                "No." := JobOrder1."No.";
                                Validate("No.");
                            end;
                            JobOrder1."Sales Order No." := "Sales Order No.";
                            JobOrder1."Sales Order Line No." := "Sales Order Line No.";
                            JobOrder1.Modify;
                        end;
                    end;
            end;

            trigger OnValidate();
            begin
                case Type of
                    Type::" ":
                        begin
                            StdTxt.Get("No.");
                            Description := StdTxt.Description;
                        end;
                    Type::Job:
                        begin
                            Job.Get("No.");
                            Description := Job.Description;
                            Quantity := 1;
                            case Job.Status of
                                Job.Status::Planning:
                                    Status := Status::Planning;
                                Job.Status::Quote:
                                    Status := Status::Quote;
                                Job.Status::Order:
                                    Status := Status::Order;
                                Job.Status::Completed:
                                    Status := Status::Completed;
                            end;
                            "Due Date" := Job."Ending Date";
                        end;
                    Type::"Prod. Order":
                        begin
                            //salesline.SETRANGE(salesline."Document No.","Sales Order No.");
                            //salesline.SETRANGE(salesline."Line No.","Sales Order Line No.");
                            if salesline.Quantity < ProductionOrder.Quantity then begin
                                Type := Type::" ";
                                "No." := ' ';
                                Error('qty is high than line');
                                //Quantity := "Prod.Order".Quantity;
                            end
                            else
                                Quantity := "Prod.Order".Quantity;
                            "Prod.Order".SetRange("No.", "No.");
                            if "Prod.Order".Find('-') then begin
                                Description := "Prod.Order".Description;

                                "Due Date" := "Prod.Order"."Due Date";
                                case "Prod.Order".Status of
                                    "Prod.Order".Status::Simulated:
                                        Status := Status::Simulated;
                                    "Prod.Order".Status::Planned:
                                        Status := Status::Planned;
                                    "Prod.Order".Status::"Firm Planned":
                                        Status := Status::"Firm Planned";
                                    "Prod.Order".Status::Released:
                                        Status := Status::Released;
                                    "Prod.Order".Status::Finished:
                                        Status := Status::Finished;
                                end;
                            end;
                        end;
                end;
            end;
        }
        field(6; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; Quantity; Decimal)
        {
            BlankZero = true;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; Status; Option)
        {
            Editable = false;
            OptionMembers = Simulated,Planned,"Firm Planned",Released,Finished,Planning,Quote,"Order",Completed;
            DataClassification = CustomerContent;
        }
        field(9; "Due Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "Sales Line Qty."; Decimal)
        {
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(11; "Schedule Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Sales Order No.", "Sales Order Line No.", "No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    var
        "Qty.": Decimal;
    begin
        CurrentTable.SetRange("Sales Order No.", "Sales Order No.");
        CurrentTable.SetRange("Sales Order Line No.", "Sales Order Line No.");
        if CurrentTable.Find('-') then
            repeat
                "Qty." := "Qty." + CurrentTable.Quantity;
            until CurrentTable.Next = 0;

        if "Qty." > "Sales Line Qty." then
            Error('You Can not Insert More than the Sales Line Qty.');
    end;

    var
        StdTxt: Record "Standard Text";
        Job: Record Job;
        "Prod.Order": Record "Production Order";
        ProductionOrder: Record "Production Order";
        ProductionOrder1: Record "Production Order";
        JobOrder: Record Job;
        JobOrder1: Record Job;
        CurrentTable: Record "SO Prod.Order Details";
        salesline: Record "Sales Line";
}

