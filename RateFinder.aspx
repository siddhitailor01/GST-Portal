<%@ Page Title="GST Rate Finder 2026 | HSN & SAC Code Search Tool | GST Champions" Language="C#" MasterPageFile="~/UserMasterPage.master" AutoEventWireup="true" CodeFile="RateFinder.aspx.cs" Inherits="RateFinder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <meta name="description" content="Search the latest GST rates for goods and services. Use our professional HSN/SAC finder and expert GST calculator for accurate tax billing in Rajasthan." />
    <meta name="keywords" content="GST Rate Finder 2026, HSN Code Search India, GST Calculator Online, SAC Code List, Tax Rate Database Bhilwara, Rajasthan GST Rates" />
    <link rel="canonical" href="https://www.gstchampions.in/RateFinder.aspx" />

    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "WebApplication",
      "name": "GST Rate Finder Pro",
      "url": "https://www.gstchampions.in/RateFinder.aspx",
      "applicationCategory": "FinancialApplication",
      "operatingSystem": "All",
      "description": "Interactive tool to find HSN codes, SAC codes, and GST tax rates for Indian businesses.",
      "offers": {
        "@type": "Offer",
        "price": "0",
        "priceCurrency": "INR"
      },
      "author": {
        "@type": "Person",
        "name": "Parikshit Mathur"
      }
    }
    </script>

    <style>
        :root {
            --brand-primary: #6366f1;
            --brand-secondary: #a855f7;
            --brand-dark: #0f172a;
            --brand-teal: #2dd4bf;
        }
        .level-hero {
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.95), rgba(99, 102, 241, 0.5)), url('https://images.unsplash.com/photo-1450101499163-c8848c66ca85?auto=format&fit=crop&q=80');
            background-size: cover;
            background-position: center;
            padding: 60px 0 80px;
            color: white;
            /*border-radius: 0 0 50px 50px;*/
            position: relative;
            overflow: hidden;
        }
        .search-glass {
            background: white;
            padding: 8px;
            border-radius: 20px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.4);
            display: flex;
            align-items: center;
            transition: 0.3s;
            border: 1px solid rgba(255,255,255,0.1);
        }
        .chip {
            cursor: pointer;
            transition: 0.3s;
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            color: white;
            padding: 8px 20px;
            border-radius: 50px;
            font-weight: 700;
            display: inline-block;
            margin: 5px;
            font-size: 0.85rem;
        }
            .chip:hover {
                background: var(--brand-primary);
                color: white;
                transform: translateY(-3px);
            }
        .rate-card {
            border: none;
            border-radius: 28px;
            transition: 0.4s;
            background: white;
            border: 1px solid #f1f5f9;
            box-shadow: 0 10px 30px rgba(0,0,0,0.02);
        }
            .rate-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 30px 60px -15px rgba(15, 23, 42, 0.1);
                border-color: var(--brand-primary);
            }
        .hsn-badge {
            background: #f5f3ff;
            color: var(--brand-primary);
            font-weight: 900;
            padding: 6px 15px;
            border-radius: 12px;
            font-size: 0.8rem;
        }
        .calc-card {
            border: none;
            border-radius: 35px;
            position: sticky;
            top: 100px;
            background: white;
            box-shadow: 0 40px 80px rgba(15, 23, 42, 0.08);
            border: 1px solid rgba(0,0,0,0.03);
        }
        .toggle-group {
            background: #f8fafc;
            border-radius: 18px;
            padding: 6px;
            display: flex;
            gap: 6px;
            border: 1px solid #e2e8f0;
        }
        .toggle-item {
            flex: 1;
            border: none;
            padding: 12px;
            border-radius: 14px;
            font-weight: 800;
            font-size: 0.8rem;
            transition: 0.3s;
            background: transparent;
            color: #64748b;
        }
            .toggle-item.active {
                background: var(--brand-dark);
                color: white;
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }
        .calc-input {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 15px;
            font-weight: 700;
            padding: 12px 20px;
        }
        .total-display {
            background: var(--brand-dark);
            color: white;
            border-radius: 20px;
            padding: 25px;
        }
        #compareBar {
            position: fixed;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--brand-dark);
            color: white;
            padding: 15px 35px;
            border-radius: 100px;
            z-index: 1000;
            display: none;
            align-items: center;
            gap: 20px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.4);
            border: 1px solid rgba(255,255,255,0.1);
        }
        .fw-900 {
            font-weight: 900 !important;
        }
        .pointer { cursor: pointer; }

        /* --- New Slab Card Styling --- */
        .slab-card {
            border-radius: 25px;
            transition: 0.3s;
            background: white;
            border: 1px solid #f1f5f9 !important;
            cursor: pointer;
        }
            .slab-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 20px 40px rgba(0,0,0,0.1) !important;
                border-color: var(--brand-primary) !important;
            }
        .mt-n5-custom {
            margin-top: -60px !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="level-hero text-center">
        <div class="container">
            <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill mb-3 fw-bold">HSN INTELLIGENCE</span>
            <h1 class="fw-900 display-5 mb-2">GST Rate Finder Pro</h1>
            <p class="opacity-50 mb-4 small text-uppercase tracking-widest">Global HSN Database • 2026 Ready</p>
            
            <div class="col-md-8 mx-auto">
                <div class="search-glass mb-4">
                    <i class="fas fa-search text-muted ms-3 me-2"></i>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control border-0 px-2 shadow-none fs-5 fw-bold" placeholder="Search by Product name or HSN..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary rounded-pill px-5 py-2 fw-bold shadow" OnClick="btnSearch_Click" OnClientClick="saveSearch()" />
                </div>
                <div class="mb-3">
                    <span class="chip" onclick="quickSearch('Mobile')">Mobile</span>
                    <span class="chip" onclick="quickSearch('Laptop')">Laptop</span>
                    <span class="chip" onclick="quickSearch('Cement')">Cement</span>
                    <span class="chip" onclick="quickSearch('Services')">Services</span>
                </div>
                <div id="recentWrapper" class="small opacity-50 mt-2">
                    <i class="fas fa-history me-2"></i>Recent: <span id="recentList"></span>
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-n5-custom position-relative" style="z-index: 5;">
        <div class="row g-3">
            <div class="col-lg col-md-4 col-6">
        <div class="card slab-card p-3 border-0 shadow-sm text-center" onclick="quickSearch('')">
            <div class="small fw-900 text-primary mb-1">RESET</div>
            <div class="display-6 fw-900 text-primary"><i class="fas fa-list-ul"></i></div>
            <div class="small opacity-50 mt-1">Show All</div>
        </div>
    </div>
            <div class="col-lg col-md-4 col-6">
                <div class="card slab-card p-3 border-0 shadow-sm text-center" onclick="quickSearch('0')">
                    <div class="small fw-900 text-muted mb-1">EXEMPT</div>
                    <div class="display-6 fw-900 text-dark">0%</div>
                    <div class="small opacity-50 mt-1">Essentials</div>
                </div>
            </div>
            <div class="col-lg col-md-4 col-6">
                <div class="card slab-card p-3 border-0 shadow-sm text-center" onclick="quickSearch('5')">
                    <div class="small fw-900 text-primary mb-1">BASIC</div>
                    <div class="display-6 fw-900 text-primary">5%</div>
                    <div class="small opacity-50 mt-1">Sugar, Yarn</div>
                </div>
            </div>
            <div class="col-lg col-md-4 col-6">
                <div class="card slab-card p-3 border-0 shadow-sm text-center" onclick="quickSearch('12')">
                    <div class="small fw-900 text-indigo mb-1">STANDARD</div>
                    <div class="display-6 fw-900 text-indigo" style="color:#6366f1">12%</div>
                    <div class="small opacity-50 mt-1">Notebooks</div>
                </div>
            </div>
            <div class="col-lg col-md-4 col-6">
                <div class="card slab-card p-3 border-0 shadow-sm text-center" onclick="quickSearch('18')">
                    <div class="small fw-900 text-secondary mb-1">COMMON</div>
                    <div class="display-6 fw-900 text-secondary" style="color:#a855f7">18%</div>
                    <div class="small opacity-50 mt-1">Mobiles, IT</div>
                </div>
            </div>
            <div class="col-lg col-md-4 col-6">
                <div class="card slab-card p-3 border-0 shadow-sm text-center" onclick="quickSearch('28')">
                    <div class="small fw-900 text-danger mb-1">LUXURY</div>
                    <div class="display-6 fw-900 text-danger">28%</div>
                    <div class="small opacity-50 mt-1">Cars, AC</div>
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-5 mb-5">
        <div class="row g-4">
            <div class="col-lg-8">
                <div class="row g-4">
                    <asp:Repeater ID="rptRates" runat="server">
                        <ItemTemplate>
                            <div class="col-12">
                                <div class="rate-card p-4 d-flex justify-content-between align-items-center">
                                    <div class="flex-grow-1">
                                        <div class="d-flex align-items-center gap-3 mb-2">
                                            <span class="hsn-badge">HSN: <%# Eval("HSNCode") %></span>
                                            <div class="form-check small text-muted">
                                                <input class="form-check-input pointer compare-check" type="checkbox" onchange='toggleCompare(this, `<%# Eval("Description").ToString().Replace("'", "") %>`, `<%# Eval("TaxRate") %>`, `<%# Eval("HSNCode") %>`)'>
                                                <label class="form-check-label pointer fw-bold">Compare</label>
                                            </div>
                                        </div>
                                        <h4 class="fw-900 mb-3 text-dark"><%# Eval("Description") %></h4>
                                        <div class="d-flex gap-2">
                                            <button type="button" class="btn btn-sm btn-light rounded-pill border-0 bg-light px-3 fw-bold" onclick='copyHSN("<%# Eval("HSNCode") %>")'><i class="far fa-copy me-1"></i> Copy</button>
                                            <button type="button" class="btn btn-sm btn-light rounded-pill border-0 bg-light px-3 fw-bold" onclick='viewDetails("<%# Eval("HSNCode") %>", "<%# Eval("Description") %>", "<%# Eval("TaxRate") %>")'>View Info</button>
                                        </div>
                                    </div>
                                    <div class="text-center ms-4 border-start ps-4">
                                        <div class="display-6 fw-900 text-primary"><%# Eval("TaxRate") %>%</div>
                                        <button type="button" class="btn btn-sm btn-outline-primary rounded-pill fw-900 px-3 mt-2" onclick='useCalc(<%# Eval("TaxRate") %>)'>Use Calc</button>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <asp:PlaceHolder ID="phNoResults" runat="server" Visible="false">
                    <div class="text-center py-5 bg-white rounded-5 shadow-sm border mt-4">
                        <h4 class="text-muted fw-900">No results found. Try a different term.</h4>
                    </div>
                </asp:PlaceHolder>
            </div>

            <div class="col-lg-4">
                <div class="card calc-card p-4 shadow-lg animate__animated animate__fadeInRight">
                    <h5 class="fw-900 mb-4 text-dark d-flex align-items-center">
                        <span class="icon-circle-sm bg-primary text-white me-3"><i class="fas fa-calculator"></i></span>
                        Expert GST Calc
                    </h5>
                    <div class="toggle-group mb-4">
                        <button type="button" id="btnExcl" class="toggle-item active" onclick="setCalcMode('exclusive')">EXCLUSIVE</button>
                        <button type="button" id="btnIncl" class="toggle-item" onclick="setCalcMode('inclusive')">INCLUSIVE</button>
                    </div>
                    <div class="mb-3">
                        <label id="lblAmt" class="small fw-900 text-muted mb-2 uppercase">Amount (Base)</label>
                        <input type="number" id="baseAmt" class="form-control calc-input fs-5" placeholder="0.00" oninput="calculate()" />
                    </div>
                    <div class="mb-4">
                        <label class="small fw-900 text-muted mb-2 uppercase">Tax Rate (%)</label>
                        <input type="number" id="taxRate" class="form-control calc-input fs-5" value="18" oninput="calculate()" />
                    </div>
                    <div class="form-check form-switch mb-4">
                        <input class="form-check-input" type="checkbox" id="isIGST" onchange="calculate()">
                        <label class="form-check-label small fw-900 text-muted">ENABLE IGST MODE</label>
                    </div>
                    <div class="total-display shadow-lg">
                        <div id="taxBreakup">
                            <div class="d-flex justify-content-between mb-2 small opacity-75"><span>CGST:</span><span id="cgstAmt">₹ 0.00</span></div>
                            <div class="d-flex justify-content-between mb-3 border-bottom border-white border-opacity-10 pb-2 small opacity-75"><span>SGST:</span><span id="sgstAmt">₹ 0.00</span></div>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="fw-bold opacity-50">Grand Total:</span>
                            <span id="totalAmt" class="display-6 fw-900 text-brand-teal" style="color:var(--brand-teal)">₹ 0.00</span>
                        </div>
                    </div>
                    <div class="text-center mt-3">
                        <button type="button" class="btn btn-link btn-sm text-decoration-none fw-bold opacity-75" onclick="showFormulaSteps()">
                            <i class="fas fa-info-circle me-1"></i> View Calculation Steps
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="compareBar">
        <span id="compStatus" class="fw-900 small uppercase">0 Items Selected</span>
        <div class="d-flex gap-2">
            <button type="button" class="btn btn-outline-light rounded-pill fw-900 px-3 btn-sm" onclick="clearAllCompare()">RESET</button>
            <button type="button" class="btn btn-primary rounded-pill fw-900 px-4 btn-sm" onclick="showCompare()">COMPARE NOW</button>
        </div>
    </div>

    <div class="modal fade" id="compareModal" tabindex="-1"><div class="modal-dialog modal-lg modal-dialog-centered"><div class="modal-content rounded-5 border-0 shadow-lg"><div class="modal-header border-0 p-4 pb-0"><h4 class="fw-900 mb-0"><i class="fas fa-columns text-primary me-2"></i>Rate Comparison</h4><button type="button" class="btn-close shadow-none" data-bs-dismiss="modal"></button></div><div class="modal-body p-4"><div class="table-responsive rounded-4 border overflow-hidden"><table class="table table-hover mb-0 text-center align-middle"><thead class="bg-light"><tr id="compHeader" class="small fw-900 text-muted uppercase"><th>Feature</th></tr></thead><tbody id="compBody" class="fw-bold text-dark"></tbody></table></div></div></div></div></div>
    <div class="modal fade" id="detailsModal" tabindex="-1"><div class="modal-dialog modal-dialog-centered"><div class="modal-content rounded-5 border-0 shadow-lg p-3"><div class="modal-body p-4 text-center"><h2 id="mName" class="fw-900 mb-2">Item Details</h2><span id="mHSN" class="badge bg-primary text-white mb-4 fs-6 rounded-pill px-4"></span><div class="p-5 bg-light rounded-5 mb-4"><p class="text-muted small fw-900 uppercase mb-1">Standard GST Tax Rate</p><h1 id="mRate" class="display-2 fw-900 text-primary mb-0">18%</h1></div><button type="button" class="btn btn-dark w-100 py-3 rounded-pill fw-900" data-bs-dismiss="modal">GOT IT</button></div></div></div></div>
    <div class="modal fade" id="formulaModal" tabindex="-1"><div class="modal-dialog modal-dialog-centered"><div class="modal-content rounded-5 border-0 shadow-lg"><div class="modal-body p-5"><h3 class="fw-900 mb-4 text-dark text-center">Calculation Logic</h3><div id="formulaContent" class="space-y-4"></div><button type="button" class="btn btn-dark w-100 py-3 rounded-pill fw-bold mt-4" data-bs-dismiss="modal">GOT IT</button></div></div></div></div>

    <script>
        let currentMode = 'exclusive';
        let compData = [];

        function quickSearch(v) {
            document.getElementById('<%= txtSearch.ClientID %>').value = v;
            document.getElementById('<%= btnSearch.ClientID %>').click();
        }

        function toggleCompare(chk, name, rate, hsn) {
            const numericRate = parseFloat(rate); 
            const item = { name: name, rate: numericRate, hsn: hsn };
            if (chk.checked) {
                if (compData.length >= 3) { alert("Maximum 3 items allowed!"); chk.checked = false; return; }
                if (!compData.find(i => i.hsn === hsn)) compData.push(item);
            } else {
                compData = compData.filter(i => i.hsn !== hsn);
            }
            let bar = document.getElementById('compareBar');
            bar.style.display = compData.length > 0 ? 'flex' : 'none';
            document.getElementById('compStatus').innerText = compData.length + " ITEMS SELECTED";
        }

        function showCompare() {
            if (compData.length < 2) { alert("Please select at least 2 items."); return; }
            let headerHTML = `<th class="text-start p-3 bg-light" style="width: 25%;">Feature</th>`;
            compData.forEach((item, index) => { headerHTML += `<th class="p-3 bg-light">Item ${index + 1}</th>`; });
        document.getElementById('compHeader').innerHTML = headerHTML;
        let bodyHTML = `
            <tr><td class="text-start fw-900 text-muted small">HSN CODE</td>${compData.map(i => `<td class="fw-bold text-primary">${i.hsn}</td>`).join('')}</tr>
            <tr><td class="text-start fw-900 text-muted small">DESCRIPTION</td>${compData.map(i => `<td class="small fw-bold">${i.name}</td>`).join('')}</tr>
            <tr><td class="text-start fw-900 text-muted small">GST RATE</td>${compData.map(i => `<td><span class="badge bg-success-subtle text-success fs-5 px-3 rounded-pill">${i.rate}%</span></td>`).join('')}</tr>`;
        document.getElementById('compBody').innerHTML = bodyHTML;
        new bootstrap.Modal(document.getElementById('compareModal')).show();
        }

        function clearAllCompare() {
            compData = [];
            document.querySelectorAll('.compare-check').forEach(chk => chk.checked = false);
            document.getElementById('compareBar').style.display = 'none';
        }

        function setCalcMode(mode) {
            currentMode = mode;
            document.getElementById('btnExcl').classList.toggle('active', mode === 'exclusive');
            document.getElementById('btnIncl').classList.toggle('active', mode === 'inclusive');
            document.getElementById('lblAmt').innerText = mode === 'exclusive' ? 'Amount (Base Price)' : 'Total (Inc. GST)';
            calculate();
        }

        function calculate() {
            let amt = parseFloat(document.getElementById('baseAmt').value) || 0;
            let rate = parseFloat(document.getElementById('taxRate').value) || 0;
            let igst = document.getElementById('isIGST').checked;
            let tax;
            if (currentMode === 'exclusive') {
                tax = (amt * rate) / 100;
                document.getElementById('totalAmt').innerText = "₹ " + (amt + tax).toLocaleString('en-IN');
            } else {
                let base = amt / (1 + (rate / 100));
                tax = amt - base;
                document.getElementById('totalAmt').innerText = "₹ " + amt.toLocaleString('en-IN');
            }
            if (igst) {
                document.getElementById('taxBreakup').innerHTML = `<div class="d-flex justify-content-between mb-2 small opacity-75"><span>IGST (${rate}%):</span><span class="fw-bold">₹ ${tax.toFixed(2)}</span></div>`;
        } else {
                document.getElementById('taxBreakup').innerHTML = `
                    <div class="d-flex justify-content-between mb-2 small opacity-75"><span>CGST (${rate/2}%):</span><span class="fw-bold">₹ ${(tax/2).toFixed(2)}</span></div>
                    <div class="d-flex justify-content-between mb-2 border-bottom border-white border-opacity-10 pb-2 small opacity-75"><span>SGST (${rate/2}%):</span><span class="fw-bold">₹ ${(tax/2).toFixed(2)}</span></div>`;
        }
        }

        function saveSearch() {
            let val = document.getElementById('<%= txtSearch.ClientID %>').value;
            if(!val) return;
            let history = JSON.parse(localStorage.getItem('gst_history') || "[]");
            if(!history.includes(val)) { history.unshift(val); history = history.slice(0, 5); }
            localStorage.setItem('gst_history', JSON.stringify(history));
        }

        window.onload = function() {
            let history = JSON.parse(localStorage.getItem('gst_history') || "[]");
            document.getElementById('recentList').innerHTML = history.map(h => `<span class="badge bg-light text-primary border me-2 pointer px-2 py-1 rounded-pill" onclick="quickSearch('${h}')">${h}</span>`).join('');
        };

        function viewDetails(h, n, r) {
            document.getElementById('mName').innerText = n;
            document.getElementById('mHSN').innerText = "HSN: " + h;
            document.getElementById('mRate').innerText = r + "%";
            new bootstrap.Modal(document.getElementById('detailsModal')).show();
        }

        function copyHSN(val) { navigator.clipboard.writeText(val); alert("HSN Code: " + val + " copied!"); }
        function useCalc(r) { document.getElementById('taxRate').value = r; calculate(); }

        function showFormulaSteps() {
            let amt = parseFloat(document.getElementById('baseAmt').value) || 0;
            let rate = parseFloat(document.getElementById('taxRate').value) || 0;
            let igst = document.getElementById('isIGST').checked;
            let content = "";
            if (currentMode === 'exclusive') {
                let tax = (amt * rate) / 100;
                content = `<div class="p-3 bg-primary-subtle rounded-4 mb-3"><h6>Step 1: GST Calc</h6><p>${amt} × ${rate}% = ₹${tax.toFixed(2)}</p></div>`;
            } else {
                let base = amt / (1 + (rate / 100));
                content = `<div class="p-3 bg-info-subtle rounded-4 mb-3"><h6>Step 1: Base Calc</h6><p>${amt} ÷ (1 + ${rate/100}) = ₹${base.toFixed(2)}</p></div>`;
        }
            document.getElementById('formulaContent').innerHTML = content;
            new bootstrap.Modal(document.getElementById('formulaModal')).show();
        }
    </script>
</asp:Content>