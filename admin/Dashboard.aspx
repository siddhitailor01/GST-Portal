<%@ Page Title="Dashboard - GST Champions" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="admin_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root { --brand-primary: #6366f1; --brand-secondary: #a855f7; --brand-success: #10b981; }
        .chart-container { position: relative; height: 300px; width: 100%; }
        .welcome-card { background: linear-gradient(135deg, var(--brand-primary) 0%, var(--brand-secondary) 100%); border-radius: 25px; color: white; padding: 40px; position: relative; overflow: hidden; }
        .welcome-card img { position: absolute; right: 20px; bottom: -10px; width: 180px; opacity: 0.2; }
        .stat-card { border: none; border-radius: 24px; transition: all 0.4s; background: white; border: 1px solid rgba(0,0,0,0.03); }
        .stat-card:hover { transform: translateY(-10px); box-shadow: 0 30px 60px -12px rgba(15, 23, 42, 0.1); }
        .icon-box { width: 55px; height: 55px; border-radius: 16px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 20px; }
        .card-value { font-size: 2.2rem; font-weight: 800; letter-spacing: -1px; color: #0f172a; }
        .card-label { font-size: 0.8rem; font-weight: 700; text-transform: uppercase; color: #64748b; letter-spacing: 1px; }
        .action-btn { background: white; border: 1px solid #e2e8f0; border-radius: 18px; padding: 20px; text-align: center; transition: 0.3s; cursor: pointer; text-decoration: none; display: block; }
        .action-btn:hover { background: #f8fafc; border-color: var(--brand-primary); }
        .action-btn i { font-size: 1.4rem; margin-bottom: 10px; color: var(--brand-primary); }
        .action-btn span { display: block; font-size: 0.75rem; font-weight: 800; color: #1e293b; text-transform: uppercase; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row mb-5">
        <div class="col-12">
            <div class="welcome-card shadow-lg">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h2 class="fw-900 mb-2">Champion Dashboard, GST!</h2>
                        <p class="opacity-75 mb-0 fs-5">Bhilwara's GST portal live updates are right here. Accuracy is our priority.</p>
                    </div>
                    <div class="col-md-4 text-end d-none d-md-block">
                        <img src="https://illustrations.popsy.co/white/data-analysis.svg" alt="Analytics" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4 mb-5">
        <div class="col-md-3">
            <div class="card stat-card p-4">
                <div class="icon-box bg-primary-subtle text-primary"><i class="fas fa-layer-group"></i></div>
                <div class="card-label">Quiz Bank</div>
                <div class="card-value"><asp:Literal ID="litTotalQuestions" runat="server">0</asp:Literal></div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stat-card p-4">
                <div class="icon-box bg-success-subtle text-success"><i class="fas fa-newspaper"></i></div>
                <div class="card-label">Articles</div>
                <div class="card-value"><asp:Literal ID="litTotalBlogs" runat="server">0</asp:Literal></div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stat-card p-4">
                <div class="icon-box bg-info-subtle text-info"><i class="fas fa-tags"></i></div>
                <div class="card-label">Rates Entry</div>
                <div class="card-value"><asp:Literal ID="litTotalRates" runat="server">0</asp:Literal></div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stat-card p-4">
                <div class="icon-box bg-warning-subtle text-warning"><i class="fas fa-headset"></i></div>
                <div class="card-label">Inquiries</div>
                <div class="card-value"><asp:Literal ID="litPendingQueries" runat="server">0</asp:Literal></div>
            </div>
        </div>
    </div>

    <div class="row g-4 mb-5">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm rounded-5 p-4 bg-white h-100">
                <h6 class="fw-900 text-dark mb-4 uppercase small"><i class="fas fa-chart-bar me-2 text-primary"></i>Content Distribution</h6>
                <div class="chart-container">
                    <canvas id="contentChart"></canvas>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm rounded-5 p-4 bg-white h-100">
                <h6 class="fw-900 text-dark mb-4 uppercase small"><i class="fas fa-chart-pie me-2 text-secondary"></i>Inquiry Breakdown</h6>
                <div class="chart-container">
                    <canvas id="inquiryChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0 rounded-5 bg-white">
                <div class="card-header bg-white border-0 py-4 px-4 d-flex justify-content-between align-items-center">
                    <h5 class="fw-900 mb-0">Recent Activity</h5>
                    <a href="ContactQueries.aspx" class="btn btn-light btn-sm rounded-pill fw-bold px-3">View Full Inbox</a>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <asp:Repeater ID="rptRecentRequests" runat="server">
                            <HeaderTemplate>
                                <table class="table align-middle mb-0">
                                    <thead class="bg-light text-muted small uppercase fw-bold">
                                        <tr><th class="ps-4">User</th><th>Category</th><th>Date</th><th class="text-center">Status</th></tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="ps-4 fw-bold text-dark"><%# Eval("FullName") %></td>
                                    <td class="small fw-600"><%# Eval("InquiryType") %></td>
                                    <td class="text-muted small"><%# Eval("CreatedDate", "{0:dd MMM yyyy}") %></td>
                                    <td class="text-center"><span class="badge bg-primary-subtle text-primary px-3 py-1 rounded-pill">Active</span></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate></tbody></table></FooterTemplate>
                        </asp:Repeater>
                        <asp:PlaceHolder ID="phEmpty" runat="server" Visible="false">
                            <div class="text-center py-5"><p class="text-muted fw-bold">No recent inquiries to display.</p></div>
                        </asp:PlaceHolder>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card border-0 shadow-sm rounded-5 p-4 bg-dark text-white h-100">
                <h6 class="text-white fw-bold mb-4 uppercase small opacity-50">Quick Workflow</h6>
                <div class="row g-3">
                    <div class="col-6"><a href="ManageLessons.aspx" class="action-btn"><i class="fas fa-plus"></i><span>Lesson</span></a></div>
                    <div class="col-6"><a href="ManageBlogs.aspx" class="action-btn"><i class="fas fa-pen"></i><span>Blog</span></a></div>
                    <div class="col-6"><a href="ManageRates.aspx" class="action-btn"><i class="fas fa-database"></i><span>Rates</span></a></div>
                    <div class="col-6"><a href="Settings.aspx" class="action-btn"><i class="fas fa-cog"></i><span>SEO</span></a></div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // FIX: Parsing Literal values safely for JavaScript
            const qCount = parseInt('<%= litTotalQuestions.Text %>') || 0;
            const bCount = parseInt('<%= litTotalBlogs.Text %>') || 0;
            const rCount = parseInt('<%= litTotalRates.Text %>') || 0;
            const iCount = parseInt('<%= litPendingQueries.Text %>') || 0;

            // 1. Content Chart
            new Chart(document.getElementById('contentChart').getContext('2d'), {
                type: 'bar',
                data: {
                    labels: ['MCQs', 'Blogs', 'Rates'],
                    datasets: [{
                        data: [qCount, bCount, rCount],
                        backgroundColor: ['#6366f1', '#a855f7', '#10b981'],
                        borderRadius: 8
                    }]
                },
                options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } } }
            });

            // 2. Inquiry Chart
            new Chart(document.getElementById('inquiryChart').getContext('2d'), {
                type: 'doughnut',
                data: {
                    labels: ['Questions', 'All Others'],
                    datasets: [{
                        data: [iCount, (qCount + bCount + rCount)],
                        backgroundColor: ['#6366f1', '#e2e8f0'],
                        borderWidth: 0
                    }]
                },
                options: { responsive: true, maintainAspectRatio: false, cutout: '75%' }
            });
        });
    </script>
</asp:Content>