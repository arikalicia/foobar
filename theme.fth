�����6J�A_s��!   -�p6�,bG��$@��Q�b   Lv?%��Tq���       V   %codec% | %bitrate% kbps | %samplerate% Hz | %channels% | %playback_time%[ / %length%]F��OմLH��.�� JIp  �\��X���/�c㱴/       �t�o�@����LQ�9          :��$��O���j���       �      (�7�_tC�l/���Ө   (�7�_tC�l/���Ө;�ӯԆE��N���   ;�ӯԆE��N���bR���.E�'�N���   bR���.E�'�N���fE�G�N�9j�����   fE�G�N�9j����Ƞ����E��@��r�   �����E��@��r�e��B�0�@��jN/+,�   e��B�0�@��jN/+,�|�w�w�E�g<���d           M{�t��}@��zX�_P           �`wEd�I�������           QiDUN�Y���C9  �y�5��bK������   ��rh�J�#�$�N��3  �nlj�6�O�7d{�]�&���.hx�L�w��H�3����}�D�ٟ:����\  �
  �  �nlj�6�O�7d{�]�&)�����TG�0��ʵ'\   �   �  �LQ�N�?~u���\脝�o�O��;qϸ�      L        by album   No��	��K��g�>�D^`   ��������       ޾M�o��H����R)t�        2   `       )�I%��H��s��)��        �   `       I6��tO�B���#��        <   `       �����&5H�<P2�3        �   `       IN���PD�8��E��        2   `                   `   ��������{    �,�����E�D9֦���      ,          ����������������   r   L  �     JScript7
  // Use with GdiDrawText() 
var DT_CENTER = 0x00000001;
var DT_VCENTER = 0x00000004;
var DT_WORDBREAK = 0x00000010;
var DT_CALCRECT = 0x00000400;
var DT_NOPREFIX = 0x00000800;

// Used in window.GetColorCUI()
var ColorTypeCUI = {
    text: 0,
    selection_text: 1,
    inactive_selection_text: 2,
    background: 3,
    selection_background: 4,
    inactive_selection_background: 5,
    active_item_frame: 6
};

// Used in window.GetFontCUI()
var FontTypeCUI = {
    items: 0,
    labels: 1
};

// Used in window.GetColorDUI()
var ColorTypeDUI = {
    text: 0,
    background: 1,
    highlight: 2,
    selection: 3
};

// Used in window.GetFontDUI()
var FontTypeDUI = {
    defaults: 0,
    tabs: 1,
    lists: 2,
    playlists: 3,
    statusbar: 4,
    console: 5
};

// Used in window.SetCursor()
var IDC_HAND = 32649;

var g_is_default_ui = window.InstanceType;
var g_font = null;
var g_text = "JScript Panel.\n\nClick here to open the editor.";
var ww = 0, wh = 0;
var g_textcolor = 0, g_textcolor_hl = 0;
var g_backcolor = 0;
var g_hot = false;
get_font();
get_colors();

function get_font() {
    if (g_is_default_ui) { // DUI
        g_font = window.GetFontDUI(FontTypeDUI.defaults);
    } else { // CUI
        g_font = window.GetFontCUI(FontTypeCUI.items);
    }
}

function get_colors() {
    if (g_is_default_ui) { // DUI
        g_textcolor = window.GetColorDUI(ColorTypeDUI.text);
        g_textcolor_hl = window.GetColorDUI(ColorTypeDUI.highlight);
        g_backcolor = window.GetColorDUI(ColorTypeDUI.background);
    } else { // CUI
        g_textcolor = window.GetColorCUI(ColorTypeCUI.text);
        g_textcolor_hl = window.GetColorCUI(ColorTypeCUI.text);
        g_backcolor = window.GetColorCUI(ColorTypeCUI.background);
    }
}

function on_size() {
    ww = window.Width;
    wh = window.Height;
}

function on_paint(gr) {
    gr.FillSolidRect(0, 0, ww, wh, g_backcolor);
    gr.GdiDrawText(g_text, g_font, g_hot ? g_textcolor_hl : g_textcolor, 0, 0, ww, wh, DT_VCENTER | DT_CENTER | DT_WORDBREAK | DT_CALCRECT | DT_NOPREFIX);
}

function on_mouse_lbtn_up(x, y) {
    window.ShowConfigure();
}

function on_mouse_move() {
    if (!g_hot) {
        g_hot = true;
        window.SetCursor(IDC_HAND);
        window.Repaint();
    }
}

function on_mouse_leave() {
    if (g_hot) {
        g_hot = false;
        window.Repaint();
    }
}

function on_font_changed() {
    get_font();
    window.Repaint();
}

function on_colors_changed() {
    get_colors();
    window.Repaint();
}
 `   ������������B��%gq���      �nlj�6�O�7d{�]�&   Splitter (left/right)���.hx�L�w��H�3   Splitter (top/bottom)�LQ�N�?~u���
   Album List\脝�o�O��;qϸ�   Album Art Viewer����}�D�ٟ:����   JScript Panel)�����TG�0��ʵ'   Playlist ViewW��w/�@�MR}at*   ����C)w2�-���rb    ��Y���H���[�b-T   ��ڞM���68   ��]��oA�-��1���   ��@���C�;�2n5����B���j>:B�fe��u� f̀k���
~�F����@� x׀