<%@ Page Title="GST FAQs | Frequently Asked Questions | GST Champions" Language="C#" MasterPageFile="~/UserMasterPage.master" AutoEventWireup="true" CodeFile="FAQs.aspx.cs" Inherits="FAQs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <meta name="description" content="Find answers to all your GST queries. Our comprehensive FAQ guide covers GST registration, filing, HSN codes, and penalty rules in Rajasthan. Expert help by Parikshit Mathur." />
    <meta name="keywords" content="GST FAQs India, GST Questions and Answers, Learn GST Bhilwara, Tax Query Rajasthan, HSN Guide, GST Filing Help" />
    <link rel="canonical" href="https://www.gstchampions.in/FAQs.aspx" />

    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "FAQPage",
      "mainEntity": [
        {
          "@type": "Question",
          "name": "How can I start learning GST from basics?",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "You can start with our Level 1 modules which cover the fundamental concepts and registration process of GST."
          }
        },
        {
          "@type": "Question",
          "name": "Does GST Champions provide support for HSN codes?",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "Yes, we have a dedicated Rate Finder tool to help you identify the correct HSN/SAC codes and their respective tax rates."
          }
        }
      ]
    }
    </script>

    <style>
        :root { 
            --brand-primary: #6366f1; 
            --brand-secondary: #a855f7; 
            --brand-dark: #0f172a;
        }

        /* --- Slimmer Support Header --- */
        .faq-header { 
             background: linear-gradient(135deg, rgba(15, 23, 42, 0.95), rgba(99, 102, 241, 0.5)), 
                        url('https://images.unsplash.com/photo-1450101499163-c8848c66ca85?auto=format&fit=crop&q=80');
            background-size: cover;
            background-position: center;
            color: white; 
            padding: 80px 0 100px; 
            /*border-radius: 0 0 60px 60px;*/
            position: relative;
            overflow: hidden;
        }

        .fw-900 { font-weight: 900 !important; }

        /* --- Floating Search Bar --- */
        .faq-search-wrapper {
            margin-top: -35px;
            margin-bottom: 60px;
            position: relative;
            z-index: 20;
        }

        .faq-search-box {
            background: white;
            border-radius: 20px;
            padding: 10px 25px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            border: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            transition: 0.3s;
        }

        .faq-search-box:focus-within {
            border-color: var(--brand-primary);
            box-shadow: 0 25px 50px rgba(99, 102, 241, 0.15);
        }

        .search-input {
            border: none;
            outline: none;
            width: 100%;
            padding: 15px;
            font-size: 1.1rem;
            font-weight: 600;
        }

        /* --- Grid Accordion Styling (6-6) --- */
.faq-grid {
    display: block; /* Flex ko hata kar block kiya taaki columns work karein */
    column-count: 2; /* Desktop par 2 columns */
    column-gap: 30px;
    margin: 0;
}

.faq-item-col {
    display: inline-block; /* Element layout ko break nahi hone dega */
    width: 100%; /* Column ke andar full width */
    padding: 0;
    margin-bottom: 30px; /* Space between vertical cards */
    -webkit-column-break-inside: avoid; /* Browser support for masonry */
    page-break-inside: avoid;
    break-inside: avoid;
}

/* Accordion Open State refinements */
.accordion-item { 
    border: 1px solid rgba(0,0,0,0.04) !important; 
    border-radius: 24px !important; 
    overflow: hidden; 
    background: #fff; 
    box-shadow: 0 10px 25px rgba(0,0,0,0.02);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    height: auto !important; /* Height auto ki taaki content ke hisab se badhe */
}

/* --- Responsive Fix for Mobile --- */
@media (max-width: 991px) {
    .faq-grid {
        column-count: 1; /* Tablet/Mobile par single column */
    }
}

        .accordion-item:hover {
            transform: translateY(-5px);
            border-color: var(--brand-primary) !important;
            box-shadow: 0 15px 30px rgba(99, 102, 241, 0.08);
        }

        .accordion-button { 
            font-weight: 800; 
            color: var(--brand-dark) !important; 
            padding: 22px 25px; 
            background: transparent !important;
            font-size: 1rem;
            box-shadow: none !important;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        .accordion-button:not(.collapsed) { color: var(--brand-primary) !important; }

        .accordion-body { 
            padding: 0 25px 25px; 
            font-size: 0.95rem; 
            line-height: 1.6; 
            color: #64748b; 
        }

        .category-badge { 
            font-size: 0.6rem; 
            text-transform: uppercase; 
            letter-spacing: 1px; 
            font-weight: 900;
            padding: 4px 10px;
            border-radius: 6px;
            background: #f1f5f9 !important;
            color: var(--brand-primary) !important;
            margin-bottom: 8px;
        }

        /* --- Footer CTA --- */
        .faq-footer {
            background: #f8fafc;
            border-radius: 40px;
            padding: 50px;
            margin-top: 60px;
            border: 1px solid #edf2f7;
        }

        @media (max-width: 991px) {
            .faq-item-col { flex: 0 0 100%; max-width: 100%; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="faq-header text-center animate__animated animate__fadeIn">
        <div class="container">
            <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill mb-3 fw-bold">KNOWLEDGE BASE</span>
            <h1 class="fw-900 display-5 mb-3">Frequently Asked Questions</h1>
            <p class="lead opacity-75 mx-auto" style="max-width: 600px;">Sahi jankari, sahi waqt par. Find answers to your GST queries below...</p>
        </div>
    </div>

    <div class="container">
        <div class="row justify-content-center faq-search-wrapper">
            <div class="col-lg-7">
                <div class="faq-search-box">
                    <i class="fas fa-magnifying-glass text-primary fs-5"></i>
                    <input type="text" id="faqSearch" class="search-input" placeholder="Search by keywords (e.g. Filing, Registration, Penalty)..." onkeyup="filterFAQs()" />
                </div>
            </div>
        </div>

        <div class="faq-grid" id="faqAccordion">
            <asp:Repeater ID="rptFAQs" runat="server">
                <ItemTemplate>
                    <div class="faq-item-col faq-card-wrapper animate__animated animate__fadeInUp">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target='#collapse<%# Eval("FAQID") %>'>
                                    <span class="category-badge"><%# Eval("Category") %></span>
                                    <span class="faq-question-text"><%# Eval("Question") %></span>
                                </button>
                            </h2>
                            <div id='collapse<%# Eval("FAQID") %>' class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">
                                    <hr class="mt-0 mb-3 opacity-5" />
                                    <%# Eval("Answer") %>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <div class="faq-footer text-center mt-5">
            <h3 class="fw-900 mb-3">Still have questions?</h3>
            <p class="text-muted mb-4 mx-auto" style="max-width: 500px;">Agar aapko apna sawal yahan nahi mila, toh fikar na karein. Humari expert team aapki madad ke liye taiyaar hai.</p>
            <a href="Contact.aspx" class="btn btn-quiz px-5 py-3 shadow-lg">
                Talk to an Expert <i class="fas fa-headset ms-2"></i>
            </a>
        </div>
    </div>

    <script>
        function filterFAQs() {
            const input = document.getElementById('faqSearch');
            const filter = input.value.toLowerCase();
            const cards = document.getElementsByClassName('faq-card-wrapper');
            let found = false;

            for (let i = 0; i < cards.length; i++) {
                const question = cards[i].querySelector('.faq-question-text').innerText.toLowerCase();
                const category = cards[i].querySelector('.category-badge').innerText.toLowerCase();
                
                if (question.includes(filter) || category.includes(filter)) {
                    cards[i].style.display = "";
                    found = true;
            } else {
                    cards[i].style.display = "none";
        }
        }
        }
    </script>
</asp:Content>