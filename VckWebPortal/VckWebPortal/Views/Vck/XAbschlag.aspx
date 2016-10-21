<%@ Page Title="X-Abschlag" Language="C#" MasterPageFile="~/Views/Shared/Copy.Master" Inherits="System.Web.Mvc.ViewPage<VckWebPortal.Models.VckModels>" %>

<asp:Content ID="Content5" ContentPlaceHolderID="MainContent" runat="server">
        <% using (Html.BeginForm(new { ReturnUrl = ViewBag.ReturnUrl })) { %>
        <%: Html.AntiForgeryToken() %>
        <%: Html.ValidationSummary(true) %>
     <% if (Request.IsAuthenticated) { %>
    <form runat="server">
        <div class="printcontent-wrapper" id="printArea">
            <h2 style="text-align:center">Unit: <%= Model.HwDispenserTrays.FirstOrDefault().unit_id %></h2>
            <hgroup class="title">
                <h2> X-Abschlag <%= ViewBag.Message %></h2>
            </hgroup>
            <% if (!ViewBag.Exported) { %>
            <div class=" cardedge-border">
            <table style="width:100%">
                    <thead>
                  <tr>
                    <th><strong>Karten aktuell</strong></th>
                    <% foreach (var item in Model.HwDispenserTrays.OrderBy(x => x.trayname))
                          {%>
                      <th> <%: item.trayname %> </th>

                      <% } %>
                  </tr>
                  </thead>
                    <tbody>
                    <tr>
                      <td></td>
                    <% foreach (var item in Model.HwDispenserTrays.OrderBy(x => x.trayname))
                          {%>
                      <td> <%: item.number_of_cards %> </td>

                      <% } %>
                  </tr>
                        </tbody>
                </table>

            <table style="width:100%" runat="server">
                <tr>
                    <th><strong>Umsätze</strong></th>
                    <td><strong>Bar:</strong> <%: (Model.VoucherCardLogs.Where(x => x.paymenttype == 2).Sum(x => x.amount) / 100).ToString("0.00") + " " + Model.Currency %></td>
                    <td></td>
                    <td></td>
                    <th><%--<strong>Transaktionen</strong>--%></th>
                    <td><%--<strong>Bar:</strong>  1234567890--%></td>
                    <%--<th><strong>Gesamtwert Münzen: 12349</strong></th>
                    <th><strong>Gesamtwert Scheine: 12349</strong></th>--%>
                </tr> 
                <tr>
                    <th></th>
                    <td><strong>EFT Gesamt:</strong> <%: (Model.VoucherCardLogs.Where(x => x.paymenttype == 1).Sum(x => x.amount) / 100).ToString("0.00") + " " + Model.Currency %></td>
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