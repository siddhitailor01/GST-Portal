<%@ Page Title="SEO & Global Settings | Admin" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="Settings.aspx.cs" Inherits="admin_Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        :root { --brand-indigo: #6366f1; --brand-purple: #a855f7; --slate-800: #1e293b; --slate-500: #64748b; }
        body { background-color: #f8fafc; }

        /* Settings Luxury Card */
        .settings-card { border: none; border-radius: 30px; background: white; box-shadow: 0 20px 50px rgba(0,0,0,0.03); padding: 40px; transition: 0.3s; }
        .settings-card:hover { box-shadow: 0 25px 60px rgba(99, 102, 241, 0.08); }
        
        .form-label { font-weight: 800; color: var(--slate-500); font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1.5px; margin-bottom: 12px; display: block; }
        .form-control { border-radius: 15px; padding: 14px 22px; border: 1px solid #e2e8f0; font-weight: 600; transition: 0.4s; background: #f8fafc; color: var(--slate-800); }
        .form-control:focus { background: white; border-color: var(--brand-indigo); box-shadow: 0 0 0 5px rgba(99, 102, 241, 0.1); outline: none; }
        
        /* Modern Button */
        .btn-save { background: linear-gradient(135deg, var(--brand-indigo), var(--brand-purple)); color: white !important; border: none; border-radius: 15px; padding: 16px 40px; font-weight: 900; text-transform: uppercase; transition: 0.4s; width: 100%; letter-spacing: 1px; }
        .btn-save:hover { transform: translateY(-4px); box-shadow: 0 15px 30px rgba(168, 85, 247, 0.3); }

        /* REAL Google Preview UI [Image of Google search result preview showing title, URL, and meta description] */
        .seo-preview { background: #ffffff; border-radius: 20px; padding: 25px; margin-top: 20px; border: 1px solid #e2e8f0; box-shadow: 0 5px 15px rgba(0,0,0,0.02); }
        .preview-title { color: #1a0dab; font-family: arial, sans-serif; font-size: 20px; line-height: 1.3; cursor: pointer; text-decoration: none; display: block; margin-bottom: 3px; }
        .preview-title:hover { text-decoration: underline; }
        .preview-url { color: #202124; font-size: 14px; font-family: arial, sans-serif; margin-bottom: 4px; display: block; }
        .preview-desc { color: #4d5156; font-size: 14px; font-family: arial, sans-serif; line-height: 1.58; }

        .stat-badge { background: #dcfce7; color: #15803d; border: 1px solid #bbf7d0; font-size: 0.75rem; }
        .section-header { border-left: 5px solid var(--brand-indigo); padding-left: 15px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-fluid py-4">
        
        <div class="d-flex justify-content-between align-items-center mb-5 animate__animated animate__fadeIn">
            <div>
                <h2 class="fw-900 text-slate-800 mb-1" style="letter-spacing: -1px;">SEO Management</h2>
                <p class="text-muted small fw-bold uppercase tracking-widest">Optimizing visibility for Bhilwara's GST Hub</p>
            </div>
            <div class="text-end">
                <span class="badge stat-badge px-4 py-2 rounded-pill fw-bold shadow-sm">
                   <i class="fas fa-satellite-dish me-2"></i>Live on Search Engines
                </span>
            </div>
        </div>

        <div class="row g-5">
            <div class="col-lg-8 animate__animated animate__fadeInLeft">
                <div class="settings-card">
                    <div class="section-header mb-5">
                        <h5 class="fw-900 mb-1 text-slate-800">Global Configuration</h5>
                        <p class="text-muted small mb-0">Yeh settings poori website ki search ranking par asar dalti hain.</p>
                    </div>
                    
                    <div class="row g-4">
                        <div class="col-12">
                            <label class="form-label">Meta Title (SEO Heading)</label>
                            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="60 characters tak likhein..."></asp:TextBox>
                            <div class="small text-muted mt-2 fw-bold italic"><i class="fas fa-info-circle me-1"></i> Character limit check automatically applied.</div>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Meta Description (Snippet Text)</label>
                            <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Website ki summary jo Google result mein dikhegi..."></asp:TextBox>
                        </div>

                        <div class="col-12">
                            <label class="form-label">SEO Keywords</label>
                            <asp:TextBox ID="txtKeywords" runat="server" CssClass="form-control" placeholder="GST Training, Parikshit Mathur, Tax Classes Bhilwara"></asp:TextBox>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Webmaster / Author</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0 rounded-start-4"><i class="fas fa-user-edit text-muted"></i></span>
                                <asp:TextBox ID="txtAuthor" runat="server" CssClass="form-control border-start-0 ps-0" placeholder="Parikshit Mathur"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Analytics Measurement ID</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0 rounded-start-4"><i class="fas fa-chart-line text-muted"></i></span>
                                <asp:TextBox ID="txtAnalytics" runat="server" CssClass="form-control border-start-0 ps-0" placeholder="G-XXXXXXXXXX"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-12 pt-4">
                            <asp:Button ID="btnSave" runat="server" Text="Commit SEO Updates" CssClass="btn btn-save shadow-lg" OnClick="btnSave_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 animate__animated animate__fadeInRight">
                <div class="settings-card h-100">
                    <h5 class="fw-900 mb-4 text-slate-800">Visual Simulation</h5>
                    <p class="small text-muted mb-4 fw-bold">Live preview of how your portal looks on Google results page.</p>
                    
                    <div class="seo-preview shadow-sm border">
                        <span class="preview-url">https://www.gstchampions.in/ <i class="fas fa-caret-down ms-1"></i></span>
                        <a href="#" class="preview-title">GST Champions | Best Learning Portal in Bhilwara</a>
                        <p class="preview-desc">Bhilwara's premium GST education hub. Learn taxation from basics to expert level with Parikshit Mathur.</p>
                    </div>

                    <div class="mt-5 p-4 bg-indigo-subtle rounded-4 border border-indigo-subtle">
                        <h6 class="fw-900 text-indigo-700 mb-2"><i class="fas fa-lightbulb me-2"></i>Optimizer Tip</h6>
                        <p class="small text-indigo-800 mb-0 leading-relaxed">
                            Aapki current description 155 characters ki hai. Google generally 160 tak allow karta hai, toh yeh **Perfect** hai!
                        </p>
                    </div>

                    <div class="mt-4 text-center">
                        <i class="fas fa-shield-virus fa-4x text-slate-200 opacity-50"></i>
                        <p class="small text-muted mt-2 fw-bold italic">Bhilwara Digital Privacy Standard v2.0</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>