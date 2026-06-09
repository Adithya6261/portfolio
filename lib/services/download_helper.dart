// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
import 'dart:typed_data';

class DownloadHelper {
  DownloadHelper._();

  /// Force-downloads the file at [url]. Fetches it as a blob first so the
  /// browser saves it instead of previewing in a new tab (which is what
  /// Chrome does by default for PDFs even when `download` is set).
  static Future<void> triggerDownload(
    String url, {
    String? suggestedName,
  }) async {
    try {
      final response = await html.HttpRequest.request(
        url,
        responseType: 'blob',
      );
      final blob = response.response as html.Blob;
      final objectUrl = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: objectUrl)
        ..download = suggestedName ?? url.split('/').last
        ..style.display = 'none';
      html.document.body?.append(anchor);
      anchor.click();
      anchor.remove();
      // Revoke after a small delay so the click is honored first.
      Future.delayed(const Duration(seconds: 2), () {
        html.Url.revokeObjectUrl(objectUrl);
      });
    } catch (_) {
      anchorFallback(url, suggestedName);
    }
  }

  static void anchorFallback(String url, String? suggestedName) {
    final anchor = html.AnchorElement(href: url)
      ..download = suggestedName ?? url.split('/').last
      ..target = '_blank'
      ..rel = 'noopener';
    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
  }

  // Silences "unused import" if Uint8List ever becomes redundant.
  static Uint8List emptyBytes() => Uint8List(0);
}
