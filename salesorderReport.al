codeunit 50107 SalesPostReport
{

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, 'Quantity', false, false)]
    local procedure salesQnty(var Rec: Record "Sales Line")
    begin
        Rec."Qty. to Ship" := 0;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    procedure ReportAfterSalesPost(var SalesHeader: Record "Sales Header")
    var
        PostedSalesInvHeader: Record "Sales Invoice Header";
    begin

        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin

            PostedSalesInvHeader.Reset();
            PostedSalesInvHeader.SetRange("Order No.", SalesHeader."No.");
            if PostedSalesInvHeader.FindFirst() then begin

                Report.Run(Report::"Standard Sales - Invoice", true, false, PostedSalesInvHeader);
            end;
        end;
    end;
}
