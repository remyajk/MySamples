<%@ Page Title="Transaktionssuche" Language="C#" MasterPageFile="~/Views/Shared/Copy.Master" Inherits="System.Web.Mvc.ViewPage<VckWebPortal.Models.VckModels>" %>

<asp:Content ID="Content5" ContentPlaceHolderID="MainContent" runat="server">
        <% using (Html.BeginForm(new { returnUrl = ViewBag.ReturnUrl })) { %>
        <%: Html.AntiForgeryToken() %>
        <%: Html.HiddenFor(m => m.VoucherCardLogs) %>
        <%: Html.ValidationSummary(true) %>
     <% if (Request.IsAuthenticated) { %>
    <form runat="server">
        <div class="printcontent-wrapper" id="printArea">
            <hgroup class="title">
                <h2> Transaktionssuche <%= ViewBag.Message %></h2>
            </hgroup>
            <div class="cardedge-border">
            <table style="width:100%" >
                    <thead>
                  <tr>
                    <th>Datum</th>
                    <th>Uhrzeit</th>
                    <th>Transaktions-Status</th>
                    <th>Transaktionsnummer</th>
                    <th>Betrag</th>
                    <th>Bezahlart</th>
                    <th>EC / CC</th>
                    <th>Kartennummer</th>
                    <th>Fach</th>
                  </tr>
                  </thead>
                    <tbody id="tbodycontent">
                       <% foreach (var item in Model.VoucherCardLogs)
                          {
                              DateTime parsedDate;
                              DateTime.TryParseExact(item.time.Substring(0, 8), "yyyyMMdd", null, System.Globalization.DateTimeStyles.None, out parsedDate);
                              %>
    <tr>
        <td>
           <%:  @Html.Encode(parsedDate.ToString("dd.MM.yyyy")) %>
        </td>
        <td>
           <%:  @Html.Encode(item.time.Substring(9)) %>
        </td>
        <td>
            <% if (item.exported == true)
               { %>
                &#10007;
            <% } %>
        </td>
        <td>
            <%: @Html.Encode(item.trxrefnum)   %>
        </td>
        <td>
            <%: @Html.Encode((item.amount/ 100.00).ToString("0.00") + " " + item.currency) %>
        </td>
        <td>
            <% if (item.paymenttype == 1) { %>
                EFT-Terminal
            <% }
               if (item.paymenttype == 2) { %>
                Cash
            <% } %>
        </td>
        <td>
            <% if (item.paymenttype == 1) { %>
                <%: @Html.Encode(item.applicationname)   %>
            <% } %>
        </td>
        <td>
            <% if (item.paymenttype == 1) { %>
                <%: @Html.Encode(item.printablecardnumber)   %>
            <% } %>
        </td>
        <td>
            <%: @Html.Encode(item.tray)%>
        </td>
    </tr>
<% }%>
                  </tbody>
                </table>
        </div>
            </div>
    <div class="content-wrapper" id="contentArea">
            <asp:Button runat="server" ID="btnDrucken" Text="Drucken" OnClientClick="javascript:PrintDivContent('printArea'); return false;" />
            <%--<asp:Button runat="server" ID="btnSchließen" Text="Schließen" OnClientClick="javascript:CloseWin();" />--%>
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
            //window.opener.location.reload();
            //CloseWin();
        }
    </script>
    <script type="text/javascript">
        function CloseWin() {
            window.open('', '_self').close();
        }
    </script>
</asp:Content>