<%@ Page Title="Z-Abschlag" Language="C#" MasterPageFile="~/Views/Shared/Copy.Master" Inherits="System.Web.Mvc.ViewPage<VckWebPortal.Models.VckModels>" %>

<asp:Content ID="Content5" ContentPlaceHolderID="MainContent" runat="server">
        <% using (Html.BeginForm(new { ReturnUrl = ViewBag.ReturnUrl })) { %>
        <%: Html.AntiForgeryToken() %>
        <%: Html.ValidationSummary(true) %>
     <% if (Request.IsAuthenticated) { %>
    <form runat="server">
        <div class="printcontent-wrapper" id="printArea">
            <h2 style="text-align:center">Unit: <%= Model.EndOfShiftReportResult.unit_id %></h2>
            <hgroup class="title">
                <h2> Z-Abschlag <%= ViewBag.Message %></h2>
            </hgroup>
            <% if (!ViewBag.Exported) { %>
            <div class=" cardedge-border">
            <table style="width:100%">
                    <tbody>
                      <tr>
                        <th><strong>Karten ausgegeben</strong></th>
                        <td><strong>Fach 1</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray1_dispensed_amount %></td>
                        <th><strong>Karten aktuell</strong></th>
                        <td><strong>Fach 1</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray1_current_amount %></td>
                      </tr>
                      <tr>
                        <th></th>
                        <td><strong>Fach 2</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray2_dispensed_amount %></td>
                        <th></th>
                        <td><strong>Fach 2</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray2_current_amount %></td>
                      </tr>
                        <tr>
                        <th></th>
                        <td><strong>Fach 3</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray3_dispensed_amount %></td>
                        <th></th>
                        <td><strong>Fach 3</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray3_current_amount %></td>
                      </tr>
                        <tr>
                        <th></th>
                        <td><strong>Fach 4</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray4_dispensed_amount %></td>
                        <th></th>
                        <td><strong>Fach 4</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray4_current_amount %></td>
                      </tr>
                        <tr>
                        <th></th>
                        <td><strong>Fach 5</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray5_dispensed_amount %></td>
                        <th></th>
                        <td><strong>Fach 5</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray5_current_amount %></td>
                      </tr>
                        <tr>
                        <th></th>
                        <td><strong>Fach 6</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray6_dispensed_amount %></td>
                        <th></th>
                        <td><strong>Fach 6</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray6_current_amount %></td>
                      </tr>
                        <tr>
                        <th></th>
                        <td><strong>Fach 7</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray7_dispensed_amount %></td>
                        <th></th>
                        <td><strong>Fach 7</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray7_current_amount %></td>
                      </tr>
                        <tr>
                        <th></th>
                        <td><strong>Fach 8</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray8_dispensed_amount %></td>
                        <th></th>
                        <td><strong>Fach 8</strong></td>
                         <td><%= Model.EndOfShiftReportResult.tray8_current_amount %></td>
                      </tr>
                    </tbody>
               </table>

            <table style="width:100%" runat="server">
                <tr>
                    <th><strong>Umsätze</strong></th>
                    <td><strong>Bar:</strong> <%: ((Model.EndOfShiftReportResult.amount_cash ?? 0) / 100).ToString("0.00") + " " + Model.Currency %></td>
                    <td></td>
                    <td></td>
                    <th><%--<strong>Transaktionen</strong>--%></th>
                    <td><%--<strong>Bar:</strong>  1234567890--%></td>
                    <%--<th><strong>Gesamtwert Münzen: 12349</strong></th>
                    <th><strong>Gesamtwert Scheine: 12349</strong></th>--%>
                </tr> 
                <tr>
                    <th></th>
                    <td><strong>EFT Gesamt:</strong> <%: ((Model.EndOfShiftReportResult.amount_cashless ?? 0) / 100).ToString("0.00") + " " + Model.Currency %></td>
                    <td><%--EC: <%= Model.EndOfShiftReportResult.amount_ec %>--%></td>
                    <td></td>
                    <th></th>
                    <td><%--<strong>EFT Gesamt:</strong> 1234567890--%></td>
                    <td><%--EC: 1234567890--%></td>
                </tr>
                <tr>
                    <th></th>
                    <td></td>
                    <td><%--CC: <%= Model.EndOfShiftReportResult.amount_creditcard %>--%></td>
                    <th></th>
                    <td></td>
                    <td></td>
                    <td><%--CC: 1234567890--%></td>
                </tr>
            </table>
                </div>
            <% } %>
        </div>
    <div class="content-wrapper" id="contentArea">
        <% if (!ViewBag.Exported) { %>
            <asp:Button runat="server" ID="btnKassenschnitt" Text="Drucken" OnClientClick="javascript:PrintDivContent('printArea'); return false" />
        <% } else { %>
            <asp:Button runat="server" ID="btnClose" Text="Schließen" Width="25%" OnClientClick="javascript:CloseWin();" />
        <% } %>
    </div>
    </form>
    <% } %>
        <% } %>
</asp:Content>

<asp:Content ID="scripts" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script type="text/javascript">
        function PrintDivContent(divId) {
            var printContent = document.getElementById(divId);

            <%--var a = document.body.appendChild(
                document.createElement("a"));
            a.download = "kassenschnitt" + <%: DateTime.Now.ToString("ddMMyyyyHHmmss") %> + ".html";
            a.href = "data:text/html," + printContent.innerHTML; // Grab the HTML
            a.click(); // Trigger a click on the element--%>

            var WinPrint = window.open('', '', 'left=0,top=0,toolbar=0,sta­tus=0,addressbar=no,menubar=no');
            WinPrint.document.write(printContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            refreshDiv();
            //window.opener.location.reload();
        }
    </script>
    <script type="text/javascript">
        function CloseWin() {
            window.open('', '_self').close();
        }
    </script>
    <script type="text/javascript">
        function refreshDiv() {

            $.ajax({
                url: "Index.aspx",

                type: "GET",
                dataType: "html",
                success: function (data) {
                    var result = $('<div />').append(data).find('#status').html();
                    $('#status').html(result);
                },
                error: function (xhr, status) {
                    alert("Sorry, there was a problem!");
                },
                complete: function (xhr, status) {
                    //$('#showresults').slideDown('slow')
                }
            });

        }
    </script>
</asp:Content>