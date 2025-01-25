#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <stdint.h>

#define SERVER "127.0.0.1"
#define PORT 8080
#define BUFLEN 512

// Function to calculate 32-bit checksum
uint32_t calculate_checksum(const char *buffer, size_t length) {
    uint32_t checksum = 0;
    for (size_t i = 0; i < length; i++) {
        checksum += buffer[i];
    }
    return ~checksum;
}

// Function to introduce artificial error (for testing)
void introduce_error(char *buffer, size_t length) {
    if (length > 0) {
        buffer[0] = ~buffer[0]; // Flip the first byte
    }
}

int main() {
    struct sockaddr_in server_addr;
    int sockfd, slen = sizeof(server_addr);
    char buffer[BUFLEN];
    char message[BUFLEN];

    // Create a UDP socket
    if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) == -1) {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }

    // Setup server address structure
    memset((char *)&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(PORT);

    if (inet_aton(SERVER, &server_addr.sin_addr) == 0) {
        perror("inet_aton() failed");
        exit(EXIT_FAILURE);
    }

    printf("Enter message: ");
    fgets(message, BUFLEN - sizeof(uint32_t), stdin);
    message[strcspn(message, "\n")] = '\0'; // Remove newline character

    // Calculate checksum
    uint32_t checksum = calculate_checksum(message, strlen(message));
    
    // Prepare the buffer with checksum and message
    memset(buffer, 0, BUFLEN);
    memcpy(buffer, &checksum, sizeof(uint32_t));
    memcpy(buffer + sizeof(uint32_t), message, strlen(message));

    // Introduce error for testing
    // Uncomment the following line to introduce an error
    // introduce_error(buffer + sizeof(uint32_t), strlen(message));

    // Send the data to the server
    if (sendto(sockfd, buffer, sizeof(uint32_t) + strlen(message), 0, (struct sockaddr *)&server_addr, slen) == -1) {
        perror("sendto() failed");
        exit(EXIT_FAILURE);
    }

    // Receive response from server
    memset(buffer, 0, BUFLEN);
    if (recvfrom(sockfd, buffer, BUFLEN, 0, (struct sockaddr *)&server_addr, &slen) == -1) {
        perror("recvfrom() failed");
        exit(EXIT_FAILURE);
    }

    printf("Server response: %s\n", buffer);

    close(sockfd);
    return 0;
}
