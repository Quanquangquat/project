package util;

import java.util.HashMap;
import java.util.Map;

/**
 * Utility class for registration status constants and related methods
 */
public class StatusUtils {
    
    // Status constants
    public static final String STATUS_PENDING = "Pending";
    public static final String STATUS_PROCESSING = "Processing";
    public static final String STATUS_APPROVED = "Approved";
    public static final String STATUS_REJECTED = "Rejected";
    public static final String STATUS_CANCELLED = "Cancelled";
    public static final String STATUS_COMPLETED = "Completed";
    public static final String STATUS_ADDITIONAL_INFO = "Additional Information Needed";
    
    // Status color mapping for UI
    private static final Map<String, String> STATUS_COLORS = new HashMap<>();
    
    static {
        STATUS_COLORS.put(STATUS_PENDING, "warning");       // Yellow
        STATUS_COLORS.put(STATUS_PROCESSING, "info");       // Blue
        STATUS_COLORS.put(STATUS_APPROVED, "success");      // Green
        STATUS_COLORS.put(STATUS_REJECTED, "danger");       // Red
        STATUS_COLORS.put(STATUS_CANCELLED, "secondary");   // Gray
        STATUS_COLORS.put(STATUS_COMPLETED, "primary");     // Dark blue
        STATUS_COLORS.put(STATUS_ADDITIONAL_INFO, "purple"); // Purple
    }
    
    /**
     * Get the Bootstrap color class for a status
     * 
     * @param status The status
     * @return The Bootstrap color class (e.g., "success", "danger")
     */
    public static String getStatusColor(String status) {
        return STATUS_COLORS.getOrDefault(status, "secondary");
    }
    
    /**
     * Get a map of all statuses and their colors
     * 
     * @return A map of status names to Bootstrap color classes
     */
    public static Map<String, String> getStatusColorMap() {
        return new HashMap<>(STATUS_COLORS);
    }
    
    /**
     * Check if a status is a final status (not pending or processing)
     * 
     * @param status The status to check
     * @return true if the status is final, false otherwise
     */
    public static boolean isFinalStatus(String status) {
        return STATUS_APPROVED.equals(status) || 
               STATUS_REJECTED.equals(status) || 
               STATUS_CANCELLED.equals(status) || 
               STATUS_COMPLETED.equals(status);
    }
    
    /**
     * Check if a status is editable by the user
     * 
     * @param status The status to check
     * @return true if the status is editable, false otherwise
     */
    public static boolean isEditable(String status) {
        return STATUS_PENDING.equals(status) || 
               STATUS_ADDITIONAL_INFO.equals(status);
    }
    
    /**
     * Check if a status is cancellable by the user
     * 
     * @param status The status to check
     * @return true if the status is cancellable, false otherwise
     */
    public static boolean isCancellable(String status) {
        return STATUS_PENDING.equals(status) || 
               STATUS_PROCESSING.equals(status) || 
               STATUS_ADDITIONAL_INFO.equals(status);
    }
    
    /**
     * Get a map of all statuses
     * 
     * @return A map of status IDs to status names
     */
    public static Map<String, String> getStatusMap() {
        Map<String, String> statusMap = new HashMap<>();
        statusMap.put(STATUS_PENDING, "Pending");
        statusMap.put(STATUS_PROCESSING, "Processing");
        statusMap.put(STATUS_APPROVED, "Approved");
        statusMap.put(STATUS_REJECTED, "Rejected");
        statusMap.put(STATUS_CANCELLED, "Cancelled");
        statusMap.put(STATUS_COMPLETED, "Completed");
        statusMap.put(STATUS_ADDITIONAL_INFO, "Additional Information Needed");
        return statusMap;
    }
} 