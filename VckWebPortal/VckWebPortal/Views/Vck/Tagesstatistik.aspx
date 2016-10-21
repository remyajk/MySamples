<%@ Page Title="Tagesstatistik" Language="C#" MasterPageFile="~/Views/Shared/Copy.Master" Inherits="System.Web.Mvc.ViewPage<VckWebPortal.Models.VckModels>" %>

<asp:Content ID="Content5" ContentPlaceHolderID="MainContent" runat="server">
        <% using (Html.BeginForm(new { returnUrl = ViewBag.ReturnUrl })) { %>
        <%: Html.AntiForgeryToken() %>
        <%: Html.HiddenFor(m => m.VoucherCardLogs) %>
        <%: Html.ValidationSummary(true) %>
     <% if (Request.IsAuthenticated) { %>
    <form runat="server">
        <div class="printcontent-wrapper" id="printArea">
            <hgroup class="title">
                <h2> Statistik <%= ViewBag.Message %></h2>
            </hgroup>
            <div class="cardedge-border">
            <table style="width:100%">
                    <thead>
                  <tr>
                    <th><strong>Karten ausgegeben</strong></th>
                    <th>Fach 1</th>
                    <th>Fach 2</th>
                    <th>Fach 3</th>
                    <th>Fach 4</th>
                    <th>Fach 5</th>
                    <th>Fach 6</th>
                    <th>Fach 7</th>
                    <th>Fach 8</th>
                  </tr>
                  </thead>
                    <tbody>
                    <tr>
                      <td></td>
                    <td><%: Model.VoucherCardLogs.Count(x => x.tray == 1) %></td>
                    <td><%: Model.VoucherCardLogs.Count(x => x.tray == 2) %></td>
                    <td><%: Model.VoucherCardLogs.Count(x => x.tray == 3) %></td>
                    <td><%: Model.VoucherCardLogs.Count(x => x.tray == 4) %></td>
                    <td><%: Model.VoucherCardLogs.Count(x => x.tray == 5) %></td>
                    <td><%: Model.VoucherCardLogs.Count(x => x.tray == 6) %></td>
                    <td><%: Model.VoucherCardLogs.Count(x => x.tray == 7) %></td>
                    <td><%: Model.VoucherCardLogs.Count(x => x.tray == 8) %></td>
                  </tr>
                        </tbody>
                </table>

           <table style="width:100%">
                <tr>
                    <th><strong>Umsätze</strong></th>
                    <td></td>
                    <td><strong>Bar:</strong> <%: (Model.VoucherCardLogs.Where(x => x.paymenttype == 2).Sum(x => x.amount) / 100).ToString("0.00") + " " + Model.Currency %></td>
                    <td></td>
                    <td></td>
                    <th><strong>Transaktionen</strong></th>
                    <td></td>
                    <td><strong>Bar:</strong> <%: Model.VoucherCardLogs.Count(x => x.paymenttype == 2) %></td>
                    <%--<th><strong>Gesamtwert Münzen: 12349</strong></th>
                    <th><strong>Gesamtwert Scheine: 12349</strong></th>--%>
                </tr> 
                <tr>
                    <th></th>
                    <td></td>
                    <td><strong>EFT Gesamt:</strong> <%: (Model.VoucherCardLogs.Where(x => x.paymenttype == 1).Sum(x => x.amount) / 100).ToString("0.00") + " " + Model.Currency %></td>
                    <td>EC: <%: (Model.VoucherCardLogs.Where(x => x.applicationname.StartsWith("ec", true, null)).Sum(x => x.amount) / 100).ToString("0.00") + " " + Model.Currency %></td>
                    <td></td>
                    <th></th>
                    <td></td>
                    <td><strong>EFT Gesamt:</strong> <%: Model.VoucherCardLogs.Count(x => x.paymenttype == 1) %></td>
                    <td>EC: <%: Model.VoucherCardLogs.Count(x =>  x.applicationname.StartsWith("ec", true, null)) %></td>
                </tr>
                <tr>
                    <th></th>
                    <td></td>
                    <td></td>
                    <td>Maestro: <%: (Model.VoucherCardLogs.Where(x =>  x.applicationname.StartsWith("maestro", true, null)).Sum(x => x.amount) / 100).ToString("0.00") + " " + Model.Currency %></td>
                    <th></th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Maestro: <%: Model.VoucherCardLogs.Count(x => x.applicationname.StartsWith("maestro", true, null)) %></td>
                </tr>
                <tr>
                    <th></th>
                    <td></td>
                    <td></td>
                    <td>MasterCard: <%: (Model.VoucherCardLogs.Where(x => x.applicationname.StartsWith("mastercard", true, null)).Sum(x => x.amount) / 100).ToString("0.00") + " " + Model.Currency %></td>
                    <th></th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>MasterCard: <%: Model.VoucherCardLogs.Count(x => x.applicationname.StartsWith("mastercard", true, null)) %></td>
                </tr>
                <tr>
                    <th></th>
                    <td></td>
                    <td></td>
                    <td>Visa: <%: (Model.VoucherCardLogs.Where(x => x.applicationname.StartsWith("visa", true, null)).Sum(x => x.amount) / 100).ToString("0.00") + " " + Model.Currency %></td>
                    <th></th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Visa: <%: Model.VoucherCardLogs.Count(x => x.applicationname.StartsWith("visa", true, null)) %></td>
                </tr>
            </table>
            <% if (Model.IncludeDetails) { %>
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
                    <th>Fach</th>
                  </tr>
                  </thead>
                    <tbody id="tbodycontent">
                       <% foreach (var item in Model.VoucherCardLogs.OrderBy(x => x.applicationname).ThenBy(x => x.time))
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
                                    <%: @Html.Encode((item.amount/ 100.00).ToString("0.00")) + " " + item.currency %>
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
                                    <%: @Html.Encode(item.tray)%>
                                </td>
                            </tr>
                            <%-- Insert Brainfuck here: Wenn dieser Datensatz gleich der späteste in einem Monat war, dann mache Monatssumme --%>
                            <%if (item.ParsedDateTime.Equals(Model.VoucherCardLogs.Where(x => x.applicationname.Equals(item.applicationname) && x.ParsedDateTime.Month.Equals(item.ParsedDateTime.Month) && x.ParsedDateTime.Year.Equals(item.ParsedDateTime.Year)).Max(x => x.ParsedDateTime))) { %>
                            
                                <tr>
                                <td style="border-top: 2px solid #cdd0d4;border-bottom: 3px solid #000000;">
                                </td>
                                <td style="border-top: 2px solid #cdd0d4;border-bottom: 3px solid #000000;">
                                   
                                </td>
                                <td style="border-top: 2px solid #cdd0d4;border-bottom: 3px solid #000000;">
                                    <strong>Summe</strong>
                                </td>
                                <td style="border-top: 2px solid #cdd0d4;border-bottom: 3px solid #000000;">
                                    <strong><%:  @Html.Encode(item.ParsedDateTime.ToString("MMMM") + " " + item.ParsedDateTime.ToString("yyyy")) %></strong>
                                </td>
                                <td style="border-top: 2px solid #cdd0d4;border-bottom: 3px solid #000000;">
                                    <strong><%: @Html.Encode((Model.VoucherCardLogs.Where(x => x.applicationname.Equals(item.applicationname) && x.ParsedDateTime.Month.Equals(item.ParsedDateTime.Month) && x.ParsedDateTime.Year.Equals(item.ParsedDateTime.Year)).Sum(x => x.amount) / 100.00).ToString("0.00") + " " + item.currency ) %></strong>
                                </td>
                                <td style="border-top: 2px solid #cdd0d4;border-bottom: 3px solid #000000;">
                                    <strong><% if (item.paymenttype == 1) { %>
                                        EFT-Terminal
                                    <% }
                                       if (item.paymenttype == 2) { %>
                                        Cash
                                    <% } %></strong>
                                </td>
                                <td style="border-top: 2px solid #cdd0d4;border-bottom: 3px solid #000000;">
                                    <strong><% if (item.paymenttype == 1) { %>
                                        <%: @Html.Encode(item.applicationname)   %>
                                    <% } %></strong>
                                </td>
                                <td style="border-top: 2px solid #cdd0d4;border-bottom: 3px solid #000000;">
                                </td>
                            </tr>
                            
                            <% }%>
                        <% }%>
                  </tbody>
                </table>
            <% }%>
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